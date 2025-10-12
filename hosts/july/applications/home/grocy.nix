{ ... }: {
  services.grocy = {
    enable = true;
    hostName = "grocy.boecker.dev";

    nginx.enableSSL = false;

    settings = {
      currency = "EUR";
      culture = "de";
      calendar = {
        showWeekNumber = true;
        firstDayOfWeek = 1;
      };
    };
  };
}