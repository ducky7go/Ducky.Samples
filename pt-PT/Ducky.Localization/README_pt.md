<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.Localization/README.md) | [English](../../en/Ducky.Localization/README_en.md) | [Deutsch](../../de/Ducky.Localization/README_de.md) | [Français](../../fr/Ducky.Localization/README_fr.md) | [Español](../../es-ES/Ducky.Localization/README_es.md) | [日本語](../../ja/Ducky.Localization/README_ja.md) | [한국어](../../ko/Ducky.Localization/README_ko.md) | [Português](README_pt.md) | [Русский](../../ru/Ducky.Localization/README_ru.md) | [繁體中文](../../zh-TW/Ducky.Localization/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.Localization exemplo mod

Breve descrição

Este exemplo mostra como definir e organizar chaves de localização em um mod autônomo e como colocar traduções em ativos para uso em tempo de execução.As definições de entrada e chave são mostradas em ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) com ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Antes de começar

Por favor, leia e prepare seu ambiente de desenvolvimento primeiro：['docs/Prequirement.md'] (docs/Prequirement.md:1)。

Estrutura do Projeto (Pontos Chave)

- ['Ducky.Localization/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — Entrada mod que demonstra como fazer referência a cadeias de caracteres localizadas.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — Definições de chave estáticas localizadas (recomenda-se que sejam mantidas no código).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1) — Contém recursos como CSV de tradução, traduções baseadas em documentos e descrições.

Chave de Localização (LK.cs)

- Em ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) usando teclas de organização constantes estáticas (por exemplo,：Classificação UI).
- O texto longo pode ser traduzido como um arquivo usando a anotação '[TranslateFile("md)]]' (que gera 'assets/Locales/{lang}/' no ficheiro).
- Para declarar um idioma suportado, use o atributo [LanguageSupport("en","en","zh-hant")]' (se desejado).

Traduzir arquivos e gerar

- Definição da palavra CSV：'ativos/Localidades/{lang}.csv', no formato Chave, Valor.
- Tradução baseada em documentos：Colocado em 'ativos/localidades/{lang}/', a mediana CSV é referenciada pelo nome do arquivo, por exemplo：'"ducky.singleproject.ui.longdescription.md"。
- 'assets/lkeys.json' e 'assets/keys.hash.txt' serão gerados pelo MSBuild do SDK em tempo de compilação para verificações de posicionamento e empacotamento em tempo de execução, portanto, não os edite manualmente.

Fluxos de trabalho recomendados

- Adicionar ou modificar chaves no seu código (recomendado)：Editar ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) e compilar, e o SDK atualiza os metadados de tradução.
- Ou edite 'ativos/localidades/ diretamente"{lang}.csv' e recompile para permitir que o SDK integre as alterações.

Exemplos de utilização

```csharp
usando Ducky.Sdk.Localizations;
mensagem var = L.UI. NiceWelcomeMessage; Resolve para uma tradução do idioma atual em tempo de execução
```

Compilar e executar

```bash
dotnet construir Ducky.Localization/
# ou construa toda a solução
dotnet construir Docky.Sdk.Sample.slnx
```

Observação

- Certifique-se de que '.csproj' está definido como '<ModName>' com o atributo geral do projeto (ver outros projetos de exemplo).
- Textos longos são recomendados para usar tradução baseada em arquivo para melhor manutenção em repositórios de código-fonte.

acabamento
