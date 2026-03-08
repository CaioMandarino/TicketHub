# TicketHub (TicketPlace iOS)

Aplicativo iOS (**SwiftUI**) desenvolvido como **trabalho final de Laboratório de Banco de Dados**.  
Este repositório contém o **client iOS** (projeto Xcode: `TicketPlace`) que consome uma **API HTTP** (por padrão em `http://localhost:8000/`).

---

## ✨ Funcionalidades (client)

- **Autenticação**
  - Cadastro de usuário
  - Login com token (Bearer)
  - “Manter login” (persistência local)

- **Eventos**
  - Listagem de eventos
  - Visualização de detalhes
  - Criar evento
  - Atualizar evento
  - Remover evento

- **Conta / Admin**
  - Atualizar nome de usuário
  - Atualizar senha
  - Buscar usuários por termo
  - Remover usuário

> Observação: as rotas e regras (ex.: permissões/admin) dependem da API. Este repo implementa o consumo do backend.

---

## 🧱 Arquitetura e stack

- **SwiftUI** + `NavigationStack`
- **MVVM + Coordinator** para fluxo de navegação
- **Async/Await** com `URLSession`
- **Actor** para isolar o serviço de rede (`NetworkService`)
- **Keychain** para armazenar token (Bearer)

---

## ✅ Requisitos

- **Xcode 26+**
- **iOS 26+** (deploy target do projeto)
- Uma **API** compatível rodando (por padrão): `http://localhost:8000/`

> Dica: `localhost` funciona bem no **iOS Simulator**. Em dispositivo físico, você precisa trocar o `baseURL` para o IP da sua máquina (ou usar um túnel como ngrok).

---

## 🚀 Como rodar (client)

1. Clone o repositório:
   ```bash
   git clone https://github.com/CaioMandarino/TicketHub.git
   cd TicketHub
