<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.senai.service.TrilhaService" %>
<%@ page import="com.senai.model.Trilha" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cursos Ganhadores:</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; padding-top: 30px; }
        .resultado-container { background: white; width: 500px; margin: 0 auto; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #343a40; color: white; }
        .vencedor { background-color: #d4edda; font-weight: bold; }
        .estatisticas { margin-top: 20px; text-align: left; background: #e9ecef; padding: 10px; border-radius: 5px; }
        .voltar { display: block; margin-top: 20px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<%
    TrilhaService senai = (TrilhaService) application.getAttribute("TrilhaService");
    Trilha vencedor = (senai != null) ? senai.getVencedor() : null;
%>

<div class="resultado-container">
    <h2>📊 Ganhadores </h2>

    <% if (senai == null) { %>
    <p>Nenhum voto recebido.</p>
    <% } else { %>

    <% if (vencedor != null) { %>
    <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
        🏆 <strong>Liderando/Vencedor:</strong> <%= vencedor.getNome() %> (<%= vencedor.getPartido() %>) com <%= vencedor.getTotalVotos() %> votos.
    </div>
    <% } else { %>
    <p><em>Ainda não há votos recebidos.</em></p>
    <% } %>

    <table>
        <tr>
            <th>Número</th>
            <th>Nome</th>
            <th>Total de Votos</th>
        </tr>
        <% for (Curso c : senai.getCursos()) {
            boolean isVencedor = (vencedor != null && c.getNumero() == vencedor.getNumero() && c.getTotalVotos() > 0);
        %>
        <tr class="<%= isVencedor ? "vencedor" : "" %>">
            <td><%= c.getNome() %></td>
            <td><%= c.getTotalVotos() %></td>
        </tr>
        <% } %>
    </table>

    <div class="estatisticas">
        <p><strong>Total Geral de Votos:</strong> <%= urna.getTotalVotosGerais() %></p>
    </div>
    <% } %>

    <a href="index.jsp" class="voltar">⬅️ Voltar para a Tela de Votação</a>
</div>

</body>
</html>