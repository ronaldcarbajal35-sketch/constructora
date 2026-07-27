import { defineCollection, z } from 'astro:content';

const cursosCollection = defineCollection({
    type: 'content',
    schema: ({ image }) => z.object({
        title: z.string(),
        description: z.string(),
        price: z.number(),
        category: z.enum(['civil', 'sistemas', 'minas']),
        image: image(),
        instructor: z.object({
            name: z.string(),
            role: z.string(),
            avatar: z.string().optional(),
        }),
        syllabus: z.array(z.object({
            title: z.string(),
            items: z.array(z.string()),
        })),
    }),
});

export const collections = {
    cursos: cursosCollection,
};
