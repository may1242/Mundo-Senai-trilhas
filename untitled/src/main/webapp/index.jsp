<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.senai.service.TrilhaService" %>
<%@ page import="com.senai.model.Trilha" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mundo Senai - Votação de Cursos</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; padding-top: 30px; }
        .urna-container { background: white; width: 500px; margin: 0 auto; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #007bff; color: white; }
        .form-group { margin-top: 20px; }
        input[type="number"] { padding: 8px; font-size: 16px; width: 100px; text-align: center; }
        button { padding: 10px 15px; font-size: 16px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #218838; }
        .botoes-especiais { margin-top: 15px; }
        .btn-branco { background-color: #ffc107; color: black; }
        .link-resultados { display: block; margin-top: 20px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<%
    TrilhaService senai = (TrilhaService) application.getAttribute("TrilhaService");
    if (senai == null) {
        String caminho = application.getRealPath("/recursos/trilhas.txt");
        try {
            com.senai.repository.TrilhaRepository repo = new com.senai.repository.TrilhaRepositoryTxt(caminho);
            senai = new TrilhaService(repo);
            application.setAttribute("TrilhaService", senai);
        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao carregar repositório: " + e.getMessage() + "</p>");
        }
    }
%>

<div class="senai-container">
    <h2>🗳️ Mundo Senai - Votação de Curso</h2>
    <p>Escolha seu curso de preferência e deixe seu voto abaixo:</p>

    <table>
        <tr>
            <th>Nome</th>
        </tr>

        <%
            if (senai != null && urna.getCursos() != null) {
                for (Curso c : urna.getCursos()) {
        %>
        <tr>
            <td><%= c.getNome() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>


    <form action="votar" method="POST" class="form-group">
        <label for="numero">Número do Candidato:</label><br><br>
        <input type="number" id="numero" name="numero" required>
        <br><br>
        <button type="submit">CONFIRMAR VOTO</button>
    </form>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List,com.senai.model.Trilha,com.senai.service.TrilhaService" %>
    <%
        request.setCharacterEncoding("UTF-8");
        TrilhaService service = TrilhaService.getInstancia();
        String mensagem = null;
        String tipoMensagem = "success";

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String idRecebido = request.getParameter("id");
            try {
                int id = Integer.parseInt(idRecebido == null ? "" : idRecebido);
                if (service.registrarVoto(id)) {
                    mensagem = "Voto computado com sucesso! Obrigado por participar.";
                    tipoMensagem = "success";
                } else {
                    mensagem = "A opção selecionada não existe. Escolha uma das trilhas disponíveis.";
                    tipoMensagem = "error";
                }
            } catch (NumberFormatException e) {
                mensagem = "Não foi possível validar seu voto. Selecione uma trilha válida.";
                tipoMensagem = "error";
            } catch (Exception e) {
                mensagem = "Ocorreu um problema ao registrar o voto. Tente novamente.";
                tipoMensagem = "error";
                application.log("Falha ao registrar voto", e);
            }
        }

        List<Trilha> trilhas = null;
        String erroLeitura = null;
        try {
            trilhas = service.listarTrilhas();
        } catch (Exception e) {
            erroLeitura = "Não foi possível carregar as trilhas. Verifique o arquivo trilhas.txt.";
            application.log("Falha ao carregar trilhas", e);
        }
    %>
    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Termômetro de Tecnologias | Mundo SENAI</title>
        <style>
            :root{--navy:#102b4e;--blue:#005ca9;--cyan:#00a6d6;--yellow:#ffd500;--bg:#f3f7fb;--text:#172b4d}
            *{box-sizing:border-box}body{margin:0;font-family:Inter,Segoe UI,Arial,sans-serif;background:var(--bg);color:var(--text)}
            header{background:linear-gradient(120deg,#092746,#005ca9);color:#fff;padding:24px max(5vw,20px);border-bottom:5px solid var(--yellow)}
            .brand{font-size:.82rem;letter-spacing:.14em;font-weight:800;color:var(--yellow)}header h1{margin:8px 0;font-size:clamp(1.7rem,4vw,2.7rem)}
            header p{margin:0;color:#d9eaff}.wrap{max-width:1050px;margin:34px auto;padding:0 20px}
            .intro{margin-bottom:24px}.intro h2{margin:0 0 8px;font-size:1.5rem}.intro p{margin:0;color:#53677f}
            .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(235px,1fr));gap:16px}
            .trilha{background:#fff;border:1px solid #dce6f0;border-radius:16px;padding:20px;box-shadow:0 5px 18px #17395b0a;display:flex;flex-direction:column;min-height:205px}
            .number{width:38px;height:38px;border-radius:11px;background:#e5f5fc;color:var(--blue);display:grid;place-items:center;font-weight:800}
            .trilha h3{margin:15px 0 8px;font-size:1.1rem}.trilha p{margin:0 0 18px;color:#5b6b7d;line-height:1.5;flex:1}
            button{width:100%;border:0;border-radius:10px;padding:13px 16px;background:var(--blue);color:white;font-weight:800;font-size:.98rem;cursor:pointer}
            button:hover{background:#00457f}button:focus-visible,a:focus-visible{outline:3px solid var(--yellow);outline-offset:3px}
            .alert{padding:14px 16px;border-radius:12px;margin:0 0 20px;font-weight:650}.success{background:#e5f8ed;color:#17683b;border:1px solid #a8e4bf}
            .error{background:#fff0ef;color:#9b2720;border:1px solid #ffc4bf}.alert-tag{font-weight:900}
            .toolbar{display:flex;justify-content:space-between;align-items:center;gap:16px;margin-top:28px;flex-wrap:wrap}
            .link{color:var(--blue);font-weight:800;text-decoration:none}.link:hover{text-decoration:underline}
            footer{text-align:center;color:#718096;padding:26px 20px;font-size:.85rem}
        </style>
    </head>
    <body>
    <header>
        <div class="brand">SENAI · MUNDO SENAI</div>
        <h1>Qual é a sua trilha?</h1>
        <p>Seu próximo passo na tecnologia começa com uma escolha.</p>
    </header>
    <main class="wrap">
        <section class="intro">
            <h2>Vote na área que mais combina com você</h2>
            <p>Explore as possibilidades e escolha sua tecnologia favorita. Cada voto ajuda a montar o termômetro da feira.</p>
        </section>

        <% if (mensagem != null) { %>
        <div class="alert <%= tipoMensagem %>" role="alert">
            <span class="alert-tag"><%= "error".equals(tipoMensagem) ? "Atenção: eu avisei" : "Tudo certo!" %></span>
            <%= mensagem %>
        </div>
        <% } %>
        <% if (erroLeitura != null) { %>
        <div class="alert error" role="alert"><span class="alert-tag">Erro:</span> <%= erroLeitura %></div>
        <% } else if (trilhas != null && !trilhas.isEmpty()) { %>
        <div class="grid">
            <% for (Trilha trilha : trilhas) { %>
            <article class="trilha">
                <div class="number"><%= trilha.getId() %></div>
                <h3><%= trilha.getNome() %></h3>
                <p><%= trilha.getDescricao() %></p>
                <form method="post" action="index.jsp">
                    <input type="hidden" name="id" value="<%= trilha.getId() %>">
                    <button type="submit" aria-label="Votar em <%= trilha.getNome() %>">Votar nesta trilha</button>
                </form>
            </article>
            <% } %>
        </div>
        <% } else if (erroLeitura == null) { %>
        <div class="alert error" role="alert">Nenhuma trilha foi cadastrada no arquivo trilhas.txt.</div>
        <% } %>
        <div class="toolbar">
            <span>Votação aberta ao público · Mundo SENAI</span>
            <a class="link" href="resultado.jsp">Ver ranking da feira →</a>
        </div>
    </main>
    <footer>SENAI · Educação Profissional e Tecnológica</footer>
    </body>
    </html>

    <div class="botoes-especiais">
        <form action="votar" method="POST" style="display:inline;">
            <input type="hidden" name="numero" value="0">
            <button type="submit" class="btn-branco">BRANCO</button>
        </form>
    </div>

    <a href="resultado.jsp" class="link-resultados">📊 Ver Resultado da Apuração</a>
</div>

</body>
</html>