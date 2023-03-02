import { IsNotEmpty, IsOptional } from "class-validator";
import { HourlyEntity } from "src/app/hourly/hourly.entity";
import { Classification } from "../enum/classification.enum";
import { Type } from "../enum/type.enum";

export class CreateMovieDto {

    @IsNotEmpty()
    name: string;


    @IsNotEmpty()
    classification: Classification;


    @IsNotEmpty()
    type: Type;


    @IsNotEmpty()
    duration: string;


    @IsNotEmpty()
    room: number

}