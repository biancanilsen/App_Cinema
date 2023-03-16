import { parse } from "path";
import { MovieEntity } from "../../movie/movie.entity";

export default class TesteMovie {
    static validMovie(): MovieEntity {
        const movie = new MovieEntity();
        movie.id = '0fc7cfa7-9749-4ffb-b7ce-21b9731e2ff3'
        movie.name = 'valid@gmail.com',
            movie.classification = 1,
            movie.type = 2,
            movie.duration = '01:30',
            movie.room = 5,
            movie.path = 'bomdia',
            movie.Hourly = [
                { timeDay: '13:30', date: new Date('2022/04/02'), id: '7e2e3676-45d3-4067-b7fa-ed208b631baa', Movie: movie }
            ];

        return movie;
    }
}