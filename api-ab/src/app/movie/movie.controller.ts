import {
    Body,
    Controller,
    Delete,
    Get,
    Param,
    ParseUUIDPipe,
    Post,
    HttpCode,
    HttpStatus,
    Headers,
    Put,
    UploadedFile,
    UseInterceptors,
    Res
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { editFileName } from '../common/utils/file-upload-rename';
import { imageFileFilter } from '../common/utils/photo-upload-validator';

import { CreateMovieDto } from './dto/create-movie.dto';
import { UpdateMovieDto } from './dto/update-movie.dto';
import { MovieService } from './movie.service';

@Controller('movie')
export class MovieController {

    constructor(private readonly movieService: MovieService) { }

    @Get()
    async index() {
        return await this.movieService.findAll();
    }

    @Get(':id')
    async show(@Param('id', new ParseUUIDPipe()) id: string) {
        return await this.movieService.findOneOrFail(id);
    }

    @Get('find/:name')
    async findByCollaborator(@Param('name') name: string) {
        return await this.movieService.findByName(name);
    }

    @Get('file/upload/:imgpath')
    seeUploadedFile(@Param('imgpath') image, @Res() res) {
        let url = image.split('.')
        return res.sendFile(image, { root: '../files' });
    }

    @Post()
    async store(@Body() body: CreateMovieDto) {
        return await this.movieService.store(body);
    }

    @Post('file/upload')
    @UseInterceptors(
        FileInterceptor('file', {
            storage: diskStorage({
                destination: '../files',
                filename: editFileName,
            }),
            fileFilter: imageFileFilter,
        }),
    )
    async uploadedFile(@UploadedFile() file) {
        const response = {
            originalname: file.originalname,
            filename: file.filename,
        };
        return response;
    }

    @Put(':id')
    async update(
        @Param('id', new ParseUUIDPipe()) id: string,
        @Body() body: UpdateMovieDto,
    ) {
        return await this.movieService.update(id, body);
    }

    @Delete(':id')
    @HttpCode(HttpStatus.NO_CONTENT)
    async destroy(@Param('id', new ParseUUIDPipe()) id: string) {
        await this.movieService.destroy(id);
    }



}


