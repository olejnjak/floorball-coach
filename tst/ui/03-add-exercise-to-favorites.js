var target = UIATarget.localTarget();
var testName = "Add exercise to favorites";

target.frontMostApp().mainWindow().collectionViews()[0].cells()["[Favorite exercises]"].buttons()["border"].tap();

var count = target.frontMostApp().mainWindow().tableViews()[0].cells().length;

target.frontMostApp().toolbar().buttons()["[Back]"].tap();

target.frontMostApp().mainWindow().collectionViews()[0].cells()["[Exercise list]"].buttons()["border"].tap();

target.frontMostApp().mainWindow().tableViews()[0].cells()[0].buttons()[0].tap();
target.frontMostApp().toolbar().buttons()["[Back]"].tap();
target.frontMostApp().mainWindow().collectionViews()[0].cells()["[Favorite exercises]"].buttons()["border"].tap();

var count2 = target.frontMostApp().mainWindow().tableViews()[0].cells().length;

target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].buttons()[0].tap();

if (count + 1 == count2)
{
	UIALogger.logPass(testName);
}
else
{
	UIALogger.logFail(testName);
}
