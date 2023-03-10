import { IsNotEmpty } from 'class-validator';
import { MovieEntity } from '../../movie/movie.entity';
export class CreateHourlyDto {

    @IsNotEmpty()
    timeDay: string;

    @IsNotEmpty()
    date: Date;

    @IsNotEmpty()
    Movie: MovieEntity;
}