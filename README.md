# AeroNav iOS — Nawigacja MapKit Liquid Glass

AeroNav to zaawansowana aplikacja nawigacyjna na system iOS (SwiftUI + MapKit), zaprojektowana z unikalnym językiem wizualnym **Liquid Glass** (kapsułki ze szkła akrylowego, dynamiczne rozmycia), pełną obsługą **Dynamic Island** (Live Activities / ActivityKit) oraz silnikiem estymacji pozycji **Dead Reckoning** (nawigacja w tunelach przy utracie sygnału GPS).

Aplikacja łączy dane z lokalnych serwisów (Waze, ADAC, Policja, radary ADS-B) z predykcyjnym asystentem AI, modułem transgranicznym i arbitrażem cen paliw.

---

## 📱 Główne Funkcjonalności

- **MapKit & Apple Maps Styling**: Płynny widok wektorowy z warstwami terenu, numeracją autostrad (np. A2, E30), wizualizacją robót drogowych, fotoradarów i stacji paliw.
- **Interfejs Liquid Glass**: Kapsułkowe elementy sterujące (`liquid-glass capsule`), opcja wyboru trybu przezroczystego lub matowego, płynne przejścia motywu i adaptacyjny tryb nocny.
- **Integracja z Dynamic Island (ActivityKit)**: Wskazówki manewrów w czasie rzeczywistym, ostrzeżenia o fotoradarach i pasach ruchu widoczne w pigułce iPhone'a oraz na zablokowanym ekranie.
- **Fala Ruchu (Traffic Wave)**: Animowana fala świetlna na trasie wskazująca precyzyjny początek zatoru, ogon korka i średnią prędkość przepływu.
- **Niezawodny GPS & Dead Reckoning**: Inteligentna estymacja inercyjna w tunelach i kanionach miejskich – pojazd płynnie kontynuuje ruch bez zamrażania pozycji.
- **Ciche Przeliczanie Trasy**: Brak natarczywych powtórzeń „Zawróć w najbliższym możliwym miejscu” przy celowej zmianie trasy.
- **Ostrzeżenia Drogowe i Radar Policji**: Raporty Waze, ADAC i zgłoszenia policji z wizualizacją mapy cieplnej (Police Heat Map) oraz detekcją helikopterów policyjnych przez transpondery ADS-B (adsb.lol).
- **Asystent Paliwowy na Granicy (PL / DE)**: Inteligentne przeliczanie poziomu baku i cen paliw w EUR i PLN (np. rekomendacja dojechania do polskiej stacji przy oszczędności 48 PLN na baku).
- **Moduł Graniczny i Weekendowy Umleitung**: Aktualne czasy oczekiwania na przejściach granicznych (Świecko, Słubice, Kostrzyn) i automatyczne objazdy przed zatorami.
- **Zielona Fala (GLOSA)**: Sugerowana prędkość dla płynnego przejazdu na zielonym świetle przez skrzyżowania.
- **Zielone Strefy (Umweltzone) & Naklejki**: Wykaz stref czystego transportu w Niemczech (Grüne Plakette Euro 4/5/6) oraz asystent parkowania docelowego.

---

## 🛠 Wymagania i Kompilacja (Xcode)

- **iOS 17.0+** / **Xcode 15.0+** / **macOS Sonoma lub nowszy**
- Frameworki: `SwiftUI`, `MapKit`, `CoreLocation`, `ActivityKit`, `Combine`, `AVFoundation`
- Budowanie pliku `.ipa`:
  1. Otwórz projekt w Xcode (`xcodebuild` lub Xcode IDE).
  2. Ustaw swój Team w *Signing & Capabilities*.
  3. Wybierz *Product -> Archive*.
  4. W oknie *Organizer* wybierz *Distribute App* -> *Ad Hoc* / *App Store Connect* i wyeksportuj `.ipa`.

---

## 📂 Struktura Projektu

```
AeroNav/
├── App/
│   └── AeroNavApp.swift              # Główny punkt wejścia aplikacji iOS
├── Models/
│   ├── NavigationModels.swift        # Modele tras, incydentów, stacji paliw, granic
│   └── SettingsModel.swift           # Model konfiguracji Liquid Glass, Waze i alertów
├── Views/
│   ├── ContentView.swift             # Główny kontener zakładek (Mapa, Zapisane, Ustawienia)
│   ├── MapView.swift                 # Widok MapKit z warstwą kapsułek Liquid Glass
│   ├── DynamicIslandWidget.swift     # Widget ActivityKit dla Dynamic Island
│   ├── SettingsView.swift            # Ekran konfiguracji alertów Waze/policji i wyglądu
│   ├── SavedPlacesView.swift         # Ulubione miejsca i menedżer map offline
│   └── BorderAndFuelSheet.swift      # Arkusz kalkulatora paliwa i przejść granicznych
├── Services/
│   ├── MapKitNavigationEngine.swift  # Silnik routingu MKDirections i fala natężenia ruchu
│   ├── DeadReckoningLocationManager.swift # Obsługa tuneli i utraty sygnału GPS
│   ├── WazeAlertsService.swift       # Serwis pobierania i filtrowania zgłoszeń
│   ├── FuelArbitrageManager.swift    # Kalkulator oszczędności transgranicznych
│   └── HapticAudioService.swift      # Haptyka CoreHaptics i dźwięki nawigacyjne
└── Resources/
    └── Info.plist                    # Uprawnienia lokalizacji, mikrofonu i tła
```
