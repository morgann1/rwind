import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  srcDir: "docs",
  base: "/rwind/",

  title: "rwind",
  description: "Tailwind-style utility classes for React-luau on Roblox.",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    search: {
      provider: 'local'
    },

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/what-is-rwind' }
    ],

    sidebar: [
      {
        text: 'Guide',
        items: [
          { text: 'What is rwind?', link: '/what-is-rwind' },
          { text: 'Getting Started', link: '/getting-started' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/morgann1/rwind' }
    ]
  }
})
