# CALICOMP DEBUG ![logo](https://github.com/APAmk2/Calicomp_Debug/raw/master/icon.png "Anna is watching you!")
## Описание ##
Calicomp Debug - проект по воссозданию Va-11 Hall-A на движке Godot по принципу Clear-Room(Воссоздание с нуля, без Reverse Engineering-а какого либо из кусков кода оригинальной игры).
## Цели ##
Полное воссоздание игры, интеграция фанатских переводов, новые возможности для моддинга, а также порт на иные платформы вроде UWP или Android.
## Что готово на данный момент ##
Оценочная готовность проекта: 25% 

Список готовых работ можно посмотреть [тут](https://github.com/APAmk2/Calicomp_Debug/blob/master/whats_done.md)
## Как использовать проект ##
1. Первым делом вам нужно скачать движок, на данный момент это Godot 4.1, найти его можно [здесь](https://github.com/godotengine/godot/releases/tag/4.1.1-stable)
2. Далее вам нужно скачать проект и распаковать его в любое удобное место
3. Теперь вам нужно с помощью [UndertaleModTools](https://github.com/krzys-h/UndertaleModTool/releases) распаковать файлы игры, для этого запустите программу и откройте файл data.win в корне игры.
4. Запустите скрипты распаковки в Scripts/Resource Unpackers такие как ExportAllSounds.csx и ExportAllSprites.csx, если программа что-то спрашивает - смело нажимайте "Да"
5. Переместите появившиеся в корне игры папки Exported_Sprites и Exported_Sounds в папку Resources в проекте
6. Запустите Godot Engine и импортируйте проект
7. Теперь можно приступать к работе
## Благодарности ##
Sukeban Games за прекрасную игру

Членам [Дискорд-сервера Va-11 Hall-a Russian Community](https://discord.gg/7r4dH4h) за посильную помощь 

Всем причастным к [UndertaleModTools](https://github.com/krzys-h/UndertaleModTool)
