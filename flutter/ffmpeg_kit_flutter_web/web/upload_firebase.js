// const firebaseConfig = {
//     apiKey: "AIzaSyC8EC6vjXVkiIkvTZuoxOLpn6DX8XL550Y",
//     authDomain: "spyn-physical-therapy.firebaseapp.com",
//     projectId: "spyn-physical-therapy",
//     storageBucket: "spyn-physical-therapy",
//     messagingSenderId: "337363482409",
//     appId: "1:337363482409:web:c3530e7dd6b5801bfae938",
//     measurementId: "G-WZJ16QHH28"
// };
// // Initialize Firebase
// firebase.initializeApp(firebaseConfig);

// firebase.auth().signInWithEmailAndPassword("c-sabari@spyn.ai", "123456")
//     .then((userCredential) => {
//         console.log("loggedin");
//         // Signed in
//         var user = userCredential.user;
//         // ...
//     })
//     .catch((error) => {
//         console.log("login error");
//         console.log(error);
//         var errorCode = error.code;
//         var errorMessage = error.message;
//     });

//uncomment till this line from the top if you want to test with an existing application which has firebase already configured.

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

window.upload = async function (imageURL, name, contentType) {
    var metadata = {
        'contentType': contentType
    };
    var url = await makeBlobRequest(imageURL).then((result) => {
        return new Promise(function (resolve, reject) {
            storageRef.child(name).put(result, metadata).then(function (snapshot) {
                console.log('Uploaded', snapshot.totalBytes, 'bytes.');
                console.log('File metadata:', snapshot.metadata);
                snapshot.ref.getDownloadURL().then(function (url) {
                    resolve(url);
                });
            })
        });
    });
    console.log('download url', url);
    return url;
};

var getBlobFromUrl = async function (url, cb) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url);
    xhr.responseType = "blob";
    xhr.addEventListener('load', function () {
        console.log("log loaded");
        cb(xhr.response);
    });
    xhr.send();
};

var getBlobFromFileUrl = async function (url) {
    var blob = await makeBlobRequest(url);
    console.log("blob");
    console.log(blob);
    return blob;
};

function makeBlobRequest(url) {
    return new Promise(function (resolve, reject) {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        xhr.responseType = "blob";
        xhr.onload = function () {
            if (this.status >= 200 && this.status < 300) {
                var blob = xhr.response
                resolve(blob);
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
