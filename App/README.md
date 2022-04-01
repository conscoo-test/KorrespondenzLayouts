# Schritte zum Erstellen der CustomerRange

1. Neuen Branch aus `master` erstellen: `Customer_Range/2022-04-01` (aktuelles Datum)
1. Id und Name in `App/app.json` austauschen

    ```json
    "id": "ae7eef02-bb60-436c-856d-d815600787b0",
    "name": "LeBit Correspondence Layouts",
    ```

    ```json
    "id": "8eba6f06-6b07-4f76-b829-2e23b81116fd",
    "name": "LeBit Correspondence Layouts (Customer Range)",
    ```
1. appId und Name für Dependency in `Test/app.json` austauschen
1. In allen Dateien (außer dieser ReadMe) ersetzen `5272` &rarr; `50`
1. In den Workspace Settings `AppSourceCop` löschen
1. VS Code neu starten
1. PermissionSet (XML) neu erstellen
1. In der `Scripts/settings.json` Pfad anpassen

    ```json
    "previousApps": "\\\\lbserver20\\Software_Business\\apps\\LeBit365_KorrespondenzLayouts (Customer Range)\\latest.zip",
    ```
1. `App/Translations/LeBit Correspondence Layouts.g.xlf` löschen (wird ansonsten als englische Übersetzung erkannt)
1. Lokal kompilieren (`Ctrl+Shift+B`) und Übersetzungen aktualisieren (`F1` &rarr; `NAB: Refresh XLF from g.xlf`)
1. Commit und Publish Branch nach DevOps
1. Pipeline `LeBit365_KorrespondenzLayouts - MinorRelease (Customer)` auf dem neuen Branch laufen lassen