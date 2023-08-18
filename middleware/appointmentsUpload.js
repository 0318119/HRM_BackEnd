const util = require("util");
const multer = require("multer");
const maxSize = 2 * 1024 * 1024;

let storageappointments = multer.diskStorage({
    destination: (req, file, cb) => {
        // //console.log("dir",__dirname + "/resources/static/assets/uploads/")
        cb(null, "./resources/static/assets/uploads/appointments/");
    },
    filename: (req, file, cb) => {
        //console.log(file.originalname);
        cb(null, file.originalname);
    },
});
let uploadAppointments = multer({
    storage: storageappointments,
    limits: { fileSize: maxSize },
}).single("file");
let uploadAppointmentsMiddleware = util.promisify(uploadAppointments);
module.exports = uploadAppointmentsMiddleware;

// code for scoop solutions.all right reserved.