import { IsOptional } from 'class-validator';
import { MovieEntity } from '../../movie/movie.entity';
export class UpdateHourlyDto {

    @IsOptional()
    timeDay: string;

    @IsOptional()
    date: Date;

    @IsOptional()
    Movie: MovieEntity;
}