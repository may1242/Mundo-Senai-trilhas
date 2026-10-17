package senai.repository;

import senai.model.Curso;

import java.util.List;

public interface TrilhaRepository {
    List<Curso> carregarCursos();
}