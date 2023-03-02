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
    Put
} from '@nestjs/common';
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

    @Post()
    async store(@Body() body: CreateMovieDto) {
        return await this.movieService.store(body);
    }

    @Get(':id')
    async show(@Param('id', new ParseUUIDPipe()) id: string) {
        return await this.movieService.findOneOrFail(id);
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


