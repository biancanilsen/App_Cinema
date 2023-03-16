import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsOptional } from "class-validator";
import { HourlyEntity } from "src/app/hourly/hourly.entity";
import { Classification } from "../enum/classification.enum";
import { Type } from "../enum/type.enum";

export class CreateMovieDto {

    @IsNotEmpty()
    @ApiProperty({ type: String })
    name: string;

    @IsNotEmpty()
    @ApiProperty({ enum: ['free', 'forAges10AndUp', 'forAges12AndUp', 'forAges14AndUp', 'forAges16AndUp', 'forAges18AndUp'] })
    classification: Classification;

    @IsNotEmpty()
    @ApiProperty({ enum: ['dubbed', 'subtitled'] })
    type: Type;

    @IsNotEmpty()
    @ApiProperty({ type: String })
    duration: string;

    @IsOptional()
    @ApiProperty({ type: String })
    path: string;

    @IsNotEmpty()
    @ApiProperty({ type: Number })
    room: number

}