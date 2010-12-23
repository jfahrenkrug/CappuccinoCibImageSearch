/*
 * Jakefile
 * capp_image_search_cib
 *
 * Created by You on December 23, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("capp_image_search_cib", function(task)
{
    task.setBuildIntermediatesPath(FILE.join("Build", "capp_image_search_cib.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("capp_image_search_cib");
    task.setIdentifier("com.yourcompany.capp_image_search_cib");
    task.setVersion("1.0");
    task.setAuthor("Your Company");
    task.setEmail("feedback @nospam@ yourcompany.com");
    task.setSummary("capp_image_search_cib");
    task.setSources((new FileList("**/*.j")).exclude(FILE.join("Build", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");
    task.setNib2CibFlags("-R Resources/");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["capp_image_search_cib"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "capp_image_search_cib", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "capp_image_search_cib", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "capp_image_search_cib"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "capp_image_search_cib"), FILE.join("Build", "Deployment", "capp_image_search_cib")]);
    printResults("Deployment")
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "capp_image_search_cib"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "capp_image_search_cib"), FILE.join("Build", "Desktop", "capp_image_search_cib", "capp_image_search_cib.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "capp_image_search_cib", "capp_image_search_cib.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "capp_image_search_cib"));
    print("----------------------------");
}
