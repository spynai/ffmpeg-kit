require(['require', 'build/flutter_assets/packages/ffmpeg_kit_flutter_web/web/@ffmpeg/ffmpeg'], function (require) {
    var namedModule = require('build/flutter_assets/packages/ffmpeg_kit_flutter_web/web/@ffmpeg/ffmpeg');
    const { createFFmpeg, fetchFile } = namedModule;
    const ffmpeg = createFFmpeg({ log: true });    
    let a =5;
});

const convertedUrl = "This is converted url";

window.testMethod = function (path) {
    return a;
}

window.convertImage2Video = function (audioPath) {
    async () => {
        await ffmpeg.load();
        ffmpeg.FS('writeFile', 'audio.ogg', await fetchFile(audioPath));
        for (let i = 0; i < 60; i += 1) {
            const num = `00${i}`.slice(-3);
            ffmpeg.FS('writeFile', `tmp.${num}.png`, await fetchFile(`../assets/triangle/tmp.${num}.png`));
        }
        await ffmpeg.run('-framerate', '30', '-pattern_type', 'glob', '-i', '*.png', '-i', 'audio.ogg', '-c:a', 'copy', '-shortest', '-c:v', 'libx264', '-pix_fmt', 'yuv420p', 'out.mp4');
        const data = ffmpeg.FS('readFile', 'out.mp4');
        ffmpeg.FS('unlink', 'audio.ogg')
        for (let i = 0; i < 60; i += 1) {
            const num = `00${i}`.slice(-3);
            ffmpeg.FS('unlink', `tmp.${num}.png`);
        }
        convertedUrl = URL.createObjectURL(new Blob([data.buffer], { type: 'video/mp4' }));
    }
    return convertedUrl;
};
