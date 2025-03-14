/* const pluginRss = require("@11ty/eleventy-plugin-rss"); */
const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");

module.exports = function (eleventyConfig) {
  // Add RSS
  /* eleventyConfig.addPlugin(pluginRss); */

  // Add syntax highlighting plugin
  eleventyConfig.addPlugin(syntaxHighlight);

  // Pass through copy for CSS and other assets
  eleventyConfig.addPassthroughCopy("css");
  eleventyConfig.addPassthroughCopy("js");
  eleventyConfig.addPassthroughCopy("assets");
  eleventyConfig.addPassthroughCopy("CNAME");

  // Add a date filter
  eleventyConfig.addFilter("dateFormat", function (date) {
    return new Date(date).toLocaleDateString("en-US", {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  });

  // Add a simpler date filter
  eleventyConfig.addFilter("date", function (date, format) {
    if (format === "%Y") {
      return new Date().getFullYear();
    }
    return new Date(date).toLocaleDateString();
  });

  // Make tags lowercase for consistency
  eleventyConfig.addFilter("lowercase", function (str) {
    return str.toLowerCase();
  });

  // Configure blog post collection
  eleventyConfig.addCollection("posts", function (collectionApi) {
    return collectionApi.getFilteredByGlob("blog/*.md").reverse();
  });

  // Create a collection of all unique tags
  eleventyConfig.addCollection("tagList", function (collectionApi) {
    const tagSet = new Set();
    collectionApi.getAll().forEach((item) => {
      if ("tags" in item.data) {
        let tags = item.data.tags;
        if (typeof tags === "string") {
          tags = [tags];
        }
        tags.forEach((tag) => {
          if (tag !== "post") {
            tagSet.add(tag.toLowerCase());
          }
        });
      }
    });
    return [...tagSet].sort();
  });

  let pathPrefix = "/";

  return {
    pathPrefix: pathPrefix,
    dir: {
      input: ".",
      output: "_site",
      includes: "_includes",
      data: "_data",
    },
    templateFormats: ["md", "njk", "html"],
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk",
  };
};
