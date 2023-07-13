// <copyright file="HomeController.cs" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
// </copyright>

namespace ForwardingBot.Bot.Controllers
{
    using Microsoft.AspNetCore.Mvc;
    using ForwardingBot.Common.Logging;

    /// <summary>
    /// The home controller class.
    /// </summary>
    public class HomeController : Controller
    {
        private readonly SampleObserver observer;

        /// <summary>
        /// Initializes a new instance of the <see cref="HomeController"/> class.
        /// </summary>
        /// <param name="observer">The observer.</param>
        public HomeController(SampleObserver observer)
        {
            this.observer = observer;
        }

        /// <summary>
        /// Get the default content of home page.
        /// </summary>
        /// <returns>Default content.</returns>
        [HttpGet("/health")]
        public string Get()
        {
            return "OK";
        }
    }
}
