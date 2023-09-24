# Install-Appx-AppxBundle
### Установка всех файлов `Appx/AppxBundle/MsixBundle` из папки `\Files`, Магазин Windows не нужен.

Добавлен подхват файлов **`XML`** лицензий для установки с лицензией при необходимости, если файл лицензии имеет начало названия как у приложения **`Appx`** или **`AppxBundle`** до символа подчёркивания: **`_`**

**Например:**
 ```
 Приложение: Microsoft.WindowsStore_12002.1001.113.0_neutral___8wekyb3d8bbwe.AppxBundle
 Лицензия: Microsoft.WindowsStore_8wekyb3d8bbwe.xml
 ```

 > Выполняется пропуск всех ненужных файлов и неподходящих разрядностей у самих приложений и зависимых пакетов **VCLib.Appx**, **.NET.Native** и др.
 > Для Windows **х64**: Пропуск arm и arm64 (ставит x64 и x86); Для Windows **x86**: Пропуск arm, arm64 и x64 (ставит только x86)

## Для установки:

 1. На сайте **https://www.microsoft.com/store/** ищем приложение, которое нас интересует, копируем ссылку или productId.
    Пример ссылки: 
    ```
    https://www.microsoft.com/ru-ru/p/intel-graphics-command-center/9plfnlnt3g5g?activetab=pivot:overviewtab
    ```
    Ссылка имеет в составе ID: **9plfnlnt3g5g**
 2. Идём на сайт **https://store.rg-adguard.net/** и там вставляем ссылку или productId (выбрав на сайте тип того, что вы вставляете).
 3. Из списка файлов скачиваем само приложение, и всё что с этим приложением идёт нужной разрядности (Для x86 нужно только x86, для x64 нужно x64 и x86).
    Обычно это само приложение **Appx** или **AppxBundle**, если их несколько версий, можно попробовать поставить все версии, они будут по очереди установлены,и вместе с ним зависимые нужные файлы **VCLib.Appx**, **.NET.Native.Appx** и др. (иногда необходимо установить все предоставленные версии этих файлов!).
 4. Складываем все скачанные файлы в папку `\Files`
 5. Запускаем `_Install_Appx_AppxBundle.bat`, запросит права администратора!
 6. Установленные приложения первый раз запускаем с подключенным интернетом. Пользуемся.

 > Файлы `.eappx`, `.eappxbundle` и `.BlockMap` не нужны, независимо от их версий и будут пропущены скриптом!

 ### Данные для установки/обновления приложений и зависимых файлов через **https://store.rg-adguard.net/** с помощью этого скрипта, пример некоторых часто используемых приложений:
 ```
  Центр управления графикой Intel   URL: https://www.microsoft.com/ru-ru/p/intel-graphics-command-center/9plfnlnt3g5g?activetab=pivot:overviewtab
 NVIDIA Control Panel              URL: https://www.microsoft.com/ru-ru/p/nvidia-control-panel/9nf8h0h7wmlt?activetab=pivot:overviewtab
 Nahimic (A-Volute, 3D audio)      URL: https://www.microsoft.com/ru-ru/p/nahimic/9n36ppmp8s23?activetab=pivot:overviewtab
 AMD Radeon Settings Lite          URL: https://www.microsoft.com/ru-ru/p/amd-radeon-settings-lite/9n9370crz0fn?activetab=pivot:overviewtab
 Armoury Crate (ASUS ROG)          URL: https://www.microsoft.com/ru-ru/p/armoury-crate-beta/9pm9dfqrdh3f?activetab=pivot:overviewtab

 MSN Погода (BingWeather)          URL: https://www.microsoft.com/ru-ru/p/msn-Погода/9wzdncrfj3q2?activetab=pivot:overviewtab или PackageFamilyName: Microsoft.BingWeather_8wekyb3d8bbwe
 FS Клиент  (Просмотр видео)       URL: https://fsclient.github.io/fs/FSClient.UWP/FSClient.UWP.appxbundle   Удалён с сайта MS, а это ссылка с их личного сайта, стороннего! https://4pda.ru/forum/index.php?showtopic=718471
 Расширения для изображений HEIF   URL: https://www.microsoft.com/ru-ru/p/Расширения-для-изображений-heif/9pmmsr1cgpwg?activetab=pivot:overviewtab
 Расширения для видео HEVC         URL: https://www.microsoft.com/ru-ru/p/Расширения-для-видео-hevc/9nmzlz57r3t7?activetab=pivot:overviewtab
 Почта и Календарь                 URL: https://www.microsoft.com/ru-ru/p/Почта-и-Календарь/9wzdncrfhvqm?activetab=pivot:overviewtab

 Microsoft.WindowsStore     CategoryID: 64293252-5926-453c-9494-2d4021f1c78d или PackageFamilyName: Microsoft.WindowsStore_8wekyb3d8bbwe  (Магазин Windows)
 Microsoft.StorePurchaseApp CategoryID: 214308d7-4262-449d-a78d-9a2306144b11  (Необходим для совершения покупок)
 Microsoft.XboxIdentityProvider    URL: https://www.microsoft.com/ru-ru/p/xbox-identity-provider/9wzdncrd1hkw?activetab=pivot:overviewtab (Необходим для подключения консоли XBox)
 Microsoft.DesktopAppInstaller     URL: https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1?activetab=pivot:overviewtab (Необходим для установки Appx по двойному клику, но не всё так можно поставить)
 ```