import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindManyOptions, Like, Repository } from 'typeorm';
import { CreateMovieDto } from './dto/create-movie.dto';
import { UpdateMovieDto } from './dto/update-movie.dto';
import { MovieEntity } from './movie.entity';

@Injectable()
export class MovieService {

    constructor(
        @InjectRepository(MovieEntity)
        private readonly movieRepository: Repository<MovieEntity>,
    ) { }

    async findAll() {
        const options: FindManyOptions = {
            // order: { createdAt: 'DESC' },
        };
        try {
            return await this.movieRepository.find(options);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async findOneOrFail(id: string) {
        try {
            return await this.movieRepository.findOne({ id });
        } catch {
            throw new NotFoundException();
        }
    }

    async findByName(name: string) {
        try {
            return await this.movieRepository.query(`select * from movie_entity me where name ILIKE'%${name}%'`)
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async store(data: CreateMovieDto) {
        try {
            const doctor = this.movieRepository.create(data);
            return await this.movieRepository.save(doctor);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async update(id: string, data: UpdateMovieDto) {
        try {
            await this.movieRepository.findOne(id);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
        return await this.movieRepository.save({ id: id, ...data });
    }

    async destroy(id: string) {
        try {
            await this.movieRepository.findOne(id);
        } catch {
            throw new NotFoundException();
        }
        return await this.movieRepository.softDelete({ id });
    }



}
