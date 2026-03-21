# vim: set ft=python:

# see the README at https://gist.github.com/phiresky/4bfcfbbd05b3c2ed8645
# source: https://github.com/mpv-player/mpv/issues/2149
# source: https://github.com/mpv-player/mpv/issues/566
# source: https://github.com/haasn/gentoo-conf/blob/nanodesu/home/nand/.mpv/filters/mvtools.vpy

import subprocess

import vapoursynth

core = vapoursynth.core
# ref: http://avisynth.org.ru/mvtools/mvtools2.html#functions
# default is 400, less means interpolation will only happen when it will work well
ignore_threshold=145
# if n% of blocks change more than threshold then don't interpolate at all (default is 51%)
scene_change_percentage=20

# if display_fps < 1:
#     dst_fps = 116
# else:
#     dst_fps = display_fps - 3

print(f'original_size: {video_in.width}x{video_in.height}')
print(f'display_fps: {display_fps}')

# proc = subprocess.run(["is-4k"])
# if proc.returncode == 0:
#     target_fps = 144
# else:
#     target_fps = 60
target_fps = 120

# target_fps = display_fps if display_fps > 1 else 144
dst_fps = container_fps
while True and container_fps < 60:
    if dst_fps + container_fps > target_fps:
        break
    dst_fps += container_fps

# dst_fps = 90

if "video_in" in globals():
    # realtime
    clip = video_in
    # Needed because clip FPS is missing
    src_fps_num = int(container_fps * 1e8)
    src_fps_den = int(1e8)
    clip = core.std.AssumeFPS(clip, fpsnum=src_fps_num, fpsden=src_fps_den)
else:
    # run with vspipe
    clip = core.ffms2.Source(source=in_filename)
    dst_fps=float(dst_fps)

if clip.width > 1920 or clip.height > 1080:
    print(f'Skip flame interpolation for large video ({clip.width}x{clip.height})')
else:
    analParams = {
        'overlap': 0,
        'search': 3,
        'truemotion': True,
    }
    blockParams = {
        'thscd1': ignore_threshold,
        'thscd2': int(scene_change_percentage*255/100),
        'mode': 0,  # yuv420p8
    }


    dst_fps_num = int(dst_fps * 1e4)
    dst_fps_den = int(1e4)
    print(f"Reflowing from {clip.fps.numerator/clip.fps.denominator} fps to {dst_fps_num/dst_fps_den} fps")

#sup  = core.mv.Super(clip, pel=2, hpad=32, vpad=32)
    sup  = core.mv.Super(clip, pel=2)
    bvec = core.mv.Analyse(sup, isb=True, **analParams)
    fvec = core.mv.Analyse(sup, isb=False, **analParams)
    clip = core.mv.BlockFPS(clip, sup, bvec, fvec, num=dst_fps_num, den=dst_fps_den, **blockParams)

clip.set_output()
