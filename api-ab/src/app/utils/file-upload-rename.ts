import { extname } from "path";

export const editFileName = (req, file, callback) => {
    const name = file.originalname.split('.')[0];
    const fileExtName = extname(file.originalname);
    const newFileName = name + "_" + Date.now() + fileExtName;
    callback(null, `${newFileName}`);

};