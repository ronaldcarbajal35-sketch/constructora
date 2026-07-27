/** @type {import('tailwindcss').Config} */
export default {
    content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
    theme: {
        extend: {
            colors: {
                navy: {
                    800: '#001f3f', // Primary Brand Color
                    900: '#001226',
                },
                brick: {
                    500: '#d35400', // Accent Color
                    600: '#a04000',
                }
            },
            fontFamily: {
                sans: ['Inter', 'sans-serif'],
            }
        },
    },
    plugins: [],
}
