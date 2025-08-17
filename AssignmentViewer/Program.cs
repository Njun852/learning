using Microsoft.Playwright;

namespace AssignmentViewer;
class Program
{
    static async Task Main(string[] args)
    {

        using var playwright = await Playwright.CreateAsync();

        await using var browser = await playwright.Chromium.LaunchAsync(new()
        {
            Headless = true, 
        });
        var page = await browser.NewPageAsync();


        //var html = await page.ContentAsync();
        //Console.WriteLine(html);
        await page.GotoAsync("https://elms.sti.edu/");
        await page.GetByRole(AriaRole.Link, new() { Name = " Log in " }).ClickAsync();
        await page.Locator(".sso_btn").ClickAsync();
        Console.Write("Enter email: ");
        string email = Console.ReadLine();
        await page.GetByPlaceholder("Email or phone").FillAsync(email);
        await page.Locator("#idSIButton9").ClickAsync();
        Console.Write("Enter password: ");
        string password = Console.ReadLine();
        await page.GetByPlaceholder("Password").FillAsync(password);
        await page.Locator("#idSIButton9").ClickAsync();
        //Console.WriteLine(html);

        await page.GetByRole(AriaRole.Link, new() { Name = "I can't use my Microsoft Authenticator app right now" }).ClickAsync();
        await page.Locator("[data-value=\"PhoneAppOTP\"]").ClickAsync();
        Console.Write("Auth Code: ");
        string code = Console.ReadLine();
        await page.GetByPlaceholder("Code").FillAsync(code);
        await page.Locator("#idSubmit_SAOTCC_Continue").ClickAsync();
        Console.WriteLine("Logging in...");
        await page.Locator("#idSIButton9").ClickAsync();

        string name = await page.Locator("a.username").Locator("span.name").InnerTextAsync();
        //string assignmentDue = await page.Locator("div.user_todo_widget").Locator("a.toggleList").InnerTextAsync();
        string assignmentDue = await page.Locator("div.user_todo_widget > ul > li > a.toggleList").InnerTextAsync();
        Console.WriteLine("Welcome " + name);
        Console.WriteLine("You have "+assignmentDue);
        Console.ReadKey();
    }
}
