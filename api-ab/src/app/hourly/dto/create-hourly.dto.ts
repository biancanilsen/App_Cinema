import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';
import { MovieEntity } from '../../movie/movie.entity';
export class CreateHourlyDto {

    @IsNotEmpty()
    @ApiProperty({ type: String })
    timeDay: string;

    @IsNotEmpty()
    @ApiProperty({ type: Date })
    date: Date;

    @IsNotEmpty()
    Movie: MovieEntity;
}