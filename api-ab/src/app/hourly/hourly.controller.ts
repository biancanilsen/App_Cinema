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
    Put,
    UseFilters
} from '@nestjs/common';
import { HttpExceptionFilter } from '../common/exception/filter';
import { CreateHourlyDto } from './dto/create-hourly.dto';
import { UpdateHourlyDto } from './dto/update-hourly.dto';
import { HourlyService } from './hourly.service';

@Controller('hourly')
export class HourlyController {

    constructor(private readonly hourlyService: HourlyService) { }

    @Get()
    @UseFilters(new HttpExceptionFilter())
    async index() {
        return await this.hourlyService.findAll();
    }

    @Get('movie/:id')
    @UseFilters(new HttpExceptionFilter())
    async findByCollaborator(@Param('id', new ParseUUIDPipe()) id: string) {
        return await this.hourlyService.findByMovie(id)
    }

    @Post()
    @UseFilters(new HttpExceptionFilter())
    async store(@Body() body: CreateHourlyDto) {
        return await this.hourlyService.store(body);
    }

    @Get(':id')
    @UseFilters(new HttpExceptionFilter())
    async show(@Param('id', new ParseUUIDPipe()) id: string) {
        return await this.hourlyService.findOneOrFail(id);
    }

    @Put(':id')
    @UseFilters(new HttpExceptionFilter())
    async update(
        @Param('id', new ParseUUIDPipe()) id: string,
        @Body() body: UpdateHourlyDto,
    ) {
        return await this.hourlyService.update(id, body);
    }

    @Delete(':id')
    @UseFilters(new HttpExceptionFilter())
    @HttpCode(HttpStatus.NO_CONTENT)
    async destroy(@Param('id', new ParseUUIDPipe()) id: string) {
        await this.hourlyService.destroy(id);
    }
}
