﻿Перем Ванесса;

Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()","ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования","я открыл форму VanessaBehavoir в режиме самотестирования");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)","ЯЗагрузилСпециальнуюТестовуюФичу","Я загрузил специальную тестовую фичу ""ОсновнаяТестоваяФича""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ДеревоТестовЗаполнилосьСтрокамиИзФичи()","ДеревоТестовЗаполнилосьСтрокамиИзФичи","ДеревоТестов заполнилось строками из фичи");

	Возврат ВсеТесты;
КонецФункции

Процедура ПередОкончаниемСценария() Экспорт
	//безусловное закрытие формы если она осталась
	Попытка
	    ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
		ОткрытаяФормаVanessaBehavoir.Закрыть();
	Исключение

	КонецПопытки;
КонецПроцедуры

//я открыл форму VanessaBehavoir в режиме самотестирования
//@ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()
Процедура ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования() Экспорт
	ПутьКОбработке = Ванесса.ИспользуемоеИмяФайла;
	НовыйЭкземпляр = ВнешниеОбработки.Создать(ПутьКОбработке);
	НовыйЭкземпляр.РежимСамотестирования = Истина;
	НовыйЭкземпляр.DebugLog = Ванесса.DebugLog;

	Форма = НовыйЭкземпляр.ПолучитьФорму("Форма");
	Ванесса.ПроверитьРавенство(Форма.Открыта(),Ложь,"Мы должны были получить новый экземпляр формы.");
	Форма.ХостСистема = Ванесса;
	Форма.Открыть();
	Контекст.Вставить("ОткрытаяФормаVanessaBehavoir",Форма);
	Контекст.Вставить("ОбработкаОбъектVanessaBehavoir",НовыйЭкземпляр);
КонецПроцедуры

//Я загрузил специальную тестовую фичу "ОсновнаяТестоваяФича"
//@ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)
Процедура ЯЗагрузилСпециальнуюТестовуюФичу(ИмяФичи) Экспорт
	Контекст.Вставить("ИмяТестовойФичи",ИмяФичи);

	ОбработкаОбъектVanessaBehavoir            = Контекст.ОбработкаОбъектVanessaBehavoir;

	ПутьКФиче = ОбработкаОбъектVanessaBehavoir.КаталогИнструментов + "\features\Support\Templates\" + ИмяФичи + ".feature";
	ФайлПроверкаСуществования = Новый Файл(ПутьКФиче);
	Если НЕ ФайлПроверкаСуществования.Существует() Тогда
		ВызватьИсключение "Файл " + ПутьКФиче + " не существует!";
	КонецЕсли;

	ОбработкаОбъектVanessaBehavoir.КаталогФич = ПутьКФиче;

	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;

	ОткрытаяФормаVanessaBehavoir.ЗагрузитьФичи();
КонецПроцедуры

//ДеревоТестов заполнилось строками из фичи
//@ДеревоТестовЗаполнилосьСтрокамиИзФичи()
Процедура ДеревоТестовЗаполнилосьСтрокамиИзФичи() Экспорт
	ОбработкаОбъектVanessaBehavoir = Контекст.ОбработкаОбъектVanessaBehavoir;

	Ванесса.ПроверитьНеРавенство(ОбработкаОбъектVanessaBehavoir.ДеревоТестов.Строки.Количество(),0,"В дереве тестов на первом уровне должны быть строки.");

	Ванесса.ПроверитьНеРавенство(ОбработкаОбъектVanessaBehavoir.ДеревоТестов.Строки[0].Строки.Количество(),0,"В дереве тестов на втором уровне должны быть строки.");
КонецПроцедуры
