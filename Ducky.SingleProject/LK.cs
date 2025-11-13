using Ducky.Sdk.Attributes;

namespace Ducky.SingleProject;

public static class LK
{
    public static class UI
    {
        public const string NiceWelcomeMessage = "ducky.singleproject.ui.nicewelcomemessage";
        public const string Title = "ducky.singleproject.ui.title";
        public const string Subtitle = "ducky.singleproject.ui.subtitle";
        public const string ButtonStart = "ducky.singleproject.ui.button.start";
        public const string ButtonExit = "ducky.singleproject.ui.button.exit";
        public const string StatusReady = "ducky.singleproject.ui.status.ready";
        public const string StatusRunning = "ducky.singleproject.ui.status.running";
        public const string StatusDone = "ducky.singleproject.ui.status.done";

        [TranslateFile("md")] // file-based long text; will create Locales/{lang}/LongDescription.md
        public const string LongDescription = "ducky.singleproject.ui.longdescription";
    }
}
