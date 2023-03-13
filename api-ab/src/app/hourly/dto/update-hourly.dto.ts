import { ApiProperty } from '@nestjs/swagger';
import { IsOptional } from 'class-validator';
import { MovieEntity } from '../../movie/movie.entity';
export class UpdateHourlyDto {

    @IsOptional()
    @ApiProperty({ type: String })
    timeDay: string;

    @IsOptional()
    @ApiProperty({ type: Date })
    date: Date;

    @IsOptional()
    Movie: MovieEntity;
}