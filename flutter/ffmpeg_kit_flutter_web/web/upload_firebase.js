const firebaseConfig = {
    apiKey: "AIzaSyC8EC6vjXVkiIkvTZuoxOLpn6DX8XL550Y",
    authDomain: "spyn-physical-therapy.firebaseapp.com",
    projectId: "spyn-physical-therapy",
    storageBucket: "spyn-physical-therapy",
    messagingSenderId: "337363482409",
    appId: "1:337363482409:web:c3530e7dd6b5801bfae938",
    measurementId: "G-WZJ16QHH28"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

firebase.auth().signInWithEmailAndPassword("c-sabari@spyn.ai", "123456")
    .then((userCredential) => {
        console.log("loggedin");
        // Signed in
        var user = userCredential.user;
        // ...
    })
    .catch((error) => {
        var errorCode = error.code;
        var errorMessage = error.message;
    });

var storageRef = firebase.storage().ref();

//test function called from html file
async function handleFileSelect(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    var file = evt.target.files[0];
    console.log("file name");
    console.log(file.name);
    var metadata = {
        'contentType': file.type
    };

    // Push to child path.
    await storageRef.child('images/' + file.name).put(file, metadata).then(function (snapshot) {
        console.log('Uploaded', snapshot.totalBytes, 'bytes.');
        console.log('File metadata:', snapshot.metadata);
        // Let's get a download URL for the file.
        snapshot.ref.getDownloadURL().then(function (url) {
            console.log('File available at', url);
        });
    }).catch(function (error) {
        console.error('Upload failed:', error);
    });
    console.log("last")
}

window.upload = new Promise(async function (imageURL, name) {

    console.log("upload from js");
    // var downloadUrl = await getFileBlob(imageURL, async function (blob) {
    //     await storageRef.child('images/' + name).put(blob).then(function (snapshot) {
    //         console.log('Uploaded', snapshot.totalBytes, 'bytes.');
    //         console.log('File metadata:', snapshot.metadata);
    //         var result;
    //         snapshot.ref.getDownloadURL().then(function (url) {
    //             result = url;
    //             console.log('File available at', result);
    //         });
    //         return result;
    //     });
    // });
    var blob = await makeRequest(imageURL);
    await storageRef.child('images/' + name).put(blob).then(function (snapshot) {
        console.log('Uploaded', snapshot.totalBytes, 'bytes.');
        console.log('File metadata:', snapshot.metadata);
        var result;
        snapshot.ref.getDownloadURL().then(function (url) {
            result = url;
            console.log('File available at', result);
            resolve(result);
        });
    });
});

var getFileBlob = async function (url, cb) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url);
    xhr.responseType = "blob";
    xhr.addEventListener('load', function () {
        console.log("log loaded");
        cb(xhr.response);
    });
    xhr.send();
};

var getFileBlobFromUrl = async function (url) {
    var blob = await makeRequest(url).then();
    console.log("blob");
    console.log(blob);
    return blob;
};

function makeRequest(url) {
    return new Promise(function (resolve, reject) {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        xhr.onload = function () {
            if (this.status >= 200 && this.status < 300) {
                var blob = xhr.response
                storageRef.child('images/' + "testing.png").put(blob).then(function (snapshot) {
                    console.log('Uploaded', snapshot.totalBytes, 'bytes.');
                    console.log('File metadata:', snapshot.metadata);
                    var result;
                    snapshot.ref.getDownloadURL().then(function (url) {
                        result = url;
                        console.log('File available at', result);
                        resolve(result);
                    });
                })
            } else {
                reject({
                    status: this.status,
                    statusText: xhr.statusText
                });
            }
        };
        xhr.onerror = function () {
            reject({
                status: this.status,
                statusText: xhr.statusText
            });
        };
        xhr.send();
    });
}
