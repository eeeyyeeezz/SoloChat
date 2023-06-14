# SoloChat

__Соло чат с возможностью писать себе + подгрузка с апи (☞ ͡° ͜ʖ ͡°)☞ Эта ветка без реалма и подов__

__Более детальные описание задания под спойлером__

[По ссылке находится гифка с реализованным проектом, нажимай ( ͡° ͜ʖ ͡ – ✧)](https://imgur.com/zTaLp49)
___

<details>
  <summary>Условия тестового ಠ╭╮ಠ</summary>

> Необходимо реализовать экран со списком сообщений (с помощью UIKit) с возможностью подгрузки сообщений с сервера. 
Сообщения должны располагаться снизу вверх друг за другом в порядке, присланном с сервера. 
Пользователь может скроллить сообщения сверху вниз (как в телеграме и других мессенджерах). 
Как только пользователь доскроллил до верха (не свайп или рефреш, а именно скролл), подгружать следующую пачку сообщений, и так пока сообщения не закончатся. 
Хронология и нумерация(!) сообщений должна соблюдаться в соответствии с offset (см. ниже).

> Можно реализовать любым способом, используя средства XCode и Swift без использования сторонних библиотек. 
На выходе должно получится полностью рабочее и интуитивно понятное приложение. 
При добавлении сообщений экран не должен перескакивать(!). Где идет загрузка - поставить индикатор загрузки. 
Поддержка светлой и темной темы. 
Заглушка и попытка повторного запроса на случай отсутствия интернета или невалидного ответа от сервера (будет приходить с некоторой вероятностью).
АПИ: https://numia.ru/api/getMessages?offset=0
offset - смещение

*Дополнение для тестового задания на позицию Middle Ios Developer:*

> Сверху экрана, над списком сообщений, должен быть статичный заголовок "Тестовое задание". 
Нативный UINavigationBar должен быть скрыт. Внизу экрана должно быть поле ввода для сообщений. 
При открытии клавиатуры поле должно подняться в соответствии с высотой клавиатуры. 
При нажатии Enter на клавиатуре в начало стека сообщений (то есть в самый низ) должно добавиться новое сообщение пользователя, поле ввода должно очиститься. 
Локальные сообщения должны сохраниться в любой локальной базе данных, при следующем запуске приложения они сразу должны быть в начале стека. 
Каждое новое сообщение, отправленное пользователем из поля ввода, должно появляться плавно. 
У каждого сообщения должна быть круглая аватарка (неважно, слева или справа), подгружаемая по любой ссылке из интернета.

> При нажатии на любое сообщение должен открыться новый экран, в котором будет подробная информация о сообщении: время отправки (любое), аватар, текст сообщения и кнопка "Удалить сообщение".
 Задизайнить этот экран нужно по своему усмотрению отталкиваясь от собственных представлений пользователького опыта в IOS-приложениях. 
Все элементы при открытии экрана должны появиться из прозрачности с анимацией в 1 секунду.
 По кнопке "Удалить" экран закрывается, сообщение удаляется из стека. 
Если удалено локальное отправленное пользователем сообщение, то оно удаляется из базы данных. 
Если удалено загруженное, то оно просто пропадает локально из стека в рамках сессии. Х
ронология дальнейших подгружаемых сообщений при этом не должна нарушиться. 
Экран также можно закрыть, не удаляя сообщение (свайпом слева направо или кнопкой "Назад").

</details>
