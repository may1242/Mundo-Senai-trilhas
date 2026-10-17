package senai.service;

import senai.model.Curso;
import senai.repository.TrilhaRepository;
import java.util.List;

public class TrilhaService {
    private TrilhaRepository repositorio;
    private List<Curso> cursos;

    public TrilhaService(TrilhaRepository repositorio) {
        this.repositorio = repositorio;
        this.cursos = repositorio.carregarCursos();
    }

    public void registrarVoto(String nomeCurso) {

        boolean achou = false;
        for (Curso c : cursos) {
            if (c.getNome() == nomeCurso) {
                c.adicionarVoto();
                achou = true;
                break;
            }
        }
    }

    public Curso getVencedor() {
        if (cursos.isEmpty()) {
            return null;
        }
        Curso vencedor = cursos.get(0);
        for (Curso c : cursos) {
            if (c.getTotalVotos() > vencedor.getTotalVotos()) {
                vencedor = c;
            }
        }
        return vencedor;
    }

    public List<Curso> getCursos() {
        return cursos;
    }
}