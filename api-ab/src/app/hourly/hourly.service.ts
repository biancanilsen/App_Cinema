import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindManyOptions, Repository } from 'typeorm';
import { CreateHourlyDto } from './dto/create-hourly.dto';
import { UpdateHourlyDto } from './dto/update-hourly.dto';
import { HourlyEntity } from './hourly.entity';

@Injectable()
export class HourlyService {

    constructor(
        @InjectRepository(HourlyEntity)
        private readonly hourlyRepository: Repository<HourlyEntity>,
    ) { }

    async findAll() {
        const options: FindManyOptions = {
            // order: { createdAt: 'DESC' },
        };
        try {
            return await this.hourlyRepository.find(options);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async findOneOrFail(id: string) {
        try {
            return await this.hourlyRepository.findOne({ id });
        } catch {
            throw new NotFoundException();
        }
    }

    async findByMovie(id: string) {
        try {
            return await this.hourlyRepository.query(`select date, "timeDay", "movieId"  from hourly_entity where "movieId" = '${id}'`)
        } catch (e) {
            console.log(e)
            throw new NotFoundException();
        }
    }
    async store(data: CreateHourlyDto) {
        try {
            const doctor = this.hourlyRepository.create(data);
            return await this.hourlyRepository.save(doctor);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async update(id: string, data: UpdateHourlyDto) {
        try {
            await this.hourlyRepository.findOne(id);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
        return await this.hourlyRepository.save({ id: id, ...data });
    }

    async destroy(id: string) {
        try {
            await this.hourlyRepository.findOne(id);
        } catch {
            throw new NotFoundException();
        }
        const deleted = await this.hourlyRepository.softDelete({ id });

        if (deleted) {
            return true;
        }

        return false;
    }


}
