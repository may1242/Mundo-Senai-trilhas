package senai.model;

public class Curso {
    private String nome;
    private int totalVotos;

    public Curso(String nome, int totalVotos) {
        this.nome = nome;
        this.totalVotos = 0;
    }

    public void adicionarVoto() {
        this.totalVotos++;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getTotalVotos() {
        return totalVotos;
    }

    public void setTotalVotos(int totalVotos) {
        this.totalVotos = totalVotos;
    }
}