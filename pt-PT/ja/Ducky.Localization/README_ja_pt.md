<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.Localization/README.md) | [Português] (../../en/Ducky.Localization/README_en.md) | [Alemão] (../../de/Ducky.Localization/README_de.md) | [Français] (../../fr/Ducky.Localization/README_fr.md) | [Español] (../../es-ES/Ducky.Localization/README_es.md) | [Japonês] (README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Português] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Chinês tradicional] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localização サンプル MOD

Breve descrição

Este exemplo mostra como definir e organizar chaves de localização em um mod autônomo e como colocar traduções em ativos para uso em tempo de execução.A entrada e as principais definições são definidas em ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Antes de começar

Primeiro, leia o ambiente de desenvolvimento e prepare-o：['ドキュメント/Prequirement.md'] (docs/Prequirement.md:1)。

Estrutura do Projeto (Pontos)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1— Uma entrada mod que mostra como fazer referência a uma cadeia de caracteres localizada.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1— Definições de chave localizadas estaticamente (recomenda-se que sejam mantidas em código).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1— Inclui recursos como CSV de tradução, traduções baseadas em documentos e explicações.

ローカライズキー(LK.cs)

- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) usando uma chave de organização constante estática (por exemplo,：Classificação UI).
- Texto longo pode ser encontrado na anotação '[TranslateFile("md)]]' ('assets/Locales/{lang}/') como um ficheiro.
- Para declarar um idioma suportado, use o atributo LanguageSupport("en","en","en-hant")]' (se necessário).

Traduzir e gerar ficheiros

- Definição da palavra CSV：'ativos/ロケール/{lang}.csv', sob a forma de chaves e valores.
- Tradução baseada em documentos：「Ativos/localidades/{lang}/', a mediana CSV é referenciada pelo nome do ficheiro (por exemplo,：'"ducky.singleproject.ui.longdescription.md"。
- 'assets/lkeys.json' e 'assets/keys.hash.txt' não devem ser editados manualmente, pois são gerados pelo MSBuild do SDK em tempo de compilação para verificações de posicionamento e empacotamento em tempo de execução.

Fluxo de trabalho recomendado

- Adicionar ou alterar chaves no seu código (recomendado)：['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) e o SDK atualiza os metadados de tradução.
- Ou edite 'ativos/localidades/ diretamente"{lang}.csv" e recompile-o para que o SDK possa integrar as alterações.

Casos de uso:

```csharp
Use Ducky.Sdk.Localizations.
var mensagem = L.UI です。 ナイスウェルカムメッセージ; Ele resolve para a tradução da linguagem atual em tempo de execução
```

Compilar e executar

```bash
dotnet construir Ducky.Localization/
# ou construa toda a solução
dotnet construir Docky.Sdk.Sample.slnx
```

Ver

- Certifique-se de que '.csproj' está definido como '.<ModName>' com o atributo General project (veja outros exemplos de projeto).
- Para textos longos, recomenda-se o uso de tradução baseada em arquivo para melhorar a manutenção do repositório de código-fonte.

Acabamento
