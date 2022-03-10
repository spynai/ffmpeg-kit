// const { myCreateFFmpeg, fetchFile } = require('./@ffmpeg/core/dist/ffmpeg-core.js');;
// const ffmpeg = myCreateFFmpeg({ log: true });

// requirejs(['require', './@ffmpeg/core/dist/ffmpeg-core.js'], function (require) {
//     var namedModule = requirejs('./@ffmpeg/core/dist/ffmpeg-core.js');
//     const { createFFmpeg } = namedModule;
//     const ffmpeg = createFFmpeg({ log: true });    
//     let a =5;
// });

const { createFFmpeg, fetchFile } = FFmpeg;
const ffmpeg = createFFmpeg({ log: true });
ffmpeg.load();

const convertedUrl = "This is converted url";

window.testMethod = function (path) {
    return a;
}

convertImage2Video =
    async () => {
        console.log('convert image to video started')
        ffmpeg.FS('writeFile', 'audio.ogg', await fetchFile('./assets/triangle/audio.ogg'));
        for (let i = 0; i < 60; i += 1) {
            const num = `00${i}`.slice(-3);
            ffmpeg.FS('writeFile', `tmp.${num}.png`, await fetchFile(`./assets/triangle/tmp.${num}.png`));
        }
        await ffmpeg.run('-framerate', '30', '-pattern_type', 'glob', '-i', '*.png', '-i', 'audio.ogg', '-c:a', 'copy', '-shortest', '-c:v', 'libx264', '-pix_fmt', 'yuv420p', 'out.mp4');
        const data = ffmpeg.FS('readFile', 'out.mp4');
        ffmpeg.FS('unlink', 'audio.ogg')
        for (let i = 0; i < 60; i += 1) {
            const num = `00${i}`.slice(-3);
            ffmpeg.FS('unlink', `tmp.${num}.png`);
        }
        var convertedUrl = URL.createObjectURL(new Blob([data.buffer], { type: 'video/mp4' }));
        console.log('convertedUrl')
        console.log(convertedUrl);
    }

const trimVideo =
    async () => {
        console.log("trimVideo")
        // const { name } = files[0];
        const name = "3_Point_Row.mp4";
        ffmpeg.FS('writeFile', name, await fetchFile('./assets/3_Point_Row.mp4'));
        await ffmpeg.run('-i', name, '-ss', '0', '-to', '5', 'output.mp4');
        const data = ffmpeg.FS('readFile', 'output.mp4');
        var convertedUrl = URL.createObjectURL(new Blob([data.buffer], { type: 'video/mp4' }));
        console.log('convertedvideo path')
        console.log(convertedUrl);
    }