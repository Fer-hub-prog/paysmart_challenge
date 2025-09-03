# 🎬 PaySmart Challenge

Aplicativo desenvolvido em **Flutter** como parte do **PaySmart Challenge**.  
O objetivo é consumir a API do [TMDb](https://www.themoviedb.org/) e exibir filmes em alta, lançamentos, detalhes e favoritos, aplicando boas práticas de arquitetura, organização e uso de pacotes modernos.

---

## 📱 Funcionalidades

- 🔑 **Tela inicial** com filmes em destaque  
- 🎥 **Listagem de filmes** populares e próximos lançamentos  
- 📖 **Detalhes do filme** com título, descrição, avaliação e imagem  
- ⭐ **Favoritos**: adicione/remova filmes da sua lista  
- 🌐 Consumo da **API do TMDb** com `Dio`  
- 📦 Gerenciamento de dependências com `get_it` e `provider`  
- 🧪 Testes unitários básicos  

---

## 🛠️ Tecnologias utilizadas

- [Flutter](https://flutter.dev/) (SDK 3.x)
- [Dart](https://dart.dev/)
- [Dio](https://pub.dev/packages/dio) - consumo de API
- [Provider](https://pub.dev/packages/provider) - gerenciamento de estado
- [GetIt](https://pub.dev/packages/get_it) - injeção de dependência
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) *(opcional, caso queira evoluir)*
- [intl](https://pub.dev/packages/intl) - formatação de datas e valores

---

## 🚀 Como rodar o projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/paysmart_challenge.git
   cd paysmart_challenge
Instale as dependências:

bash
Copiar código
flutter pub get
Crie o arquivo local.properties dentro da pasta android/ (se não existir):

properties
Copiar código
sdk.dir=C:\\Users\\SEU_USUARIO\\AppData\\Local\\Android\\Sdk
flutter.sdk=C:\\DevPrograms\\flutter
Rode no emulador ou dispositivo físico:

bash
Copiar código
flutter run --dart-define=TMDB_API_KEY=SUA_CHAVE_AQUI
⚠️ É necessário obter uma chave de API gratuita no site do TMDb.

📂 Estrutura de pastas
bash
Copiar código
lib/
 ├── core/                # Configurações globais
 ├── features/
 │    └── movies/         # Módulo de filmes
 │         ├── data/      # Models e acesso à API
 │         ├── domain/    # Entidades e casos de uso
 │         ├── presentation/ # Telas e widgets
 │         └── providers.dart
 └── main.dart            # Ponto de entrada da aplicação
🖼️ Screenshots
Tela inicial

Emulador em execução

✅ Próximos passos (Roadmap)
 Implementar busca por filmes

 Melhorar testes unitários e de widget

 Adicionar dark mode

 Publicar no GitHub Pages (Web)

👨‍💻 Autor
Desenvolvido por Fernando Rodrigues
📧 Entre em contato: LinkedIn

📜 Licença
Este projeto é apenas para fins de estudo e aprendizado.
Baseado em Flutter + TMDb API.