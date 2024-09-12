<p align="center">
    <a href="https://ecourse.pockethost.io/" target="_blank" rel="noopener">
        <img src="https://i.ibb.co/Sx7YmY6/ecourse.jpg" alt="eCourse - My Courses" />
    </a>
</p>

eCourse is a self-hosted SPA designed to simplify course creation and management, some of the features include:

- ability to create video and text based content
- ability to assign courses to users
- ability to track users progress

[Demo](https://ecourse.pockethost.io/)

Use the following credentials for testing the demo:

**Username:** `ilyas`  
**Password:** `ecourse123`

## Tech Stack

**UI Framework** - [Svelte](https://svelte.dev/)

**CSS** - [TailwindCSS](https://tailwindcss.com/)

**Icons** - [Iconify](https://iconify.design/)

**Backend** - [PocketBase](https://pocketbase.io/)

**Hosting** - [PocketHost](https://pockethost.io/)

## Getting Started

Get started by running the project locally, simply follow these steps:

1. Clone/download the repo

2. Grab the PocketBase executable for your OS from: https://pocketbase.io/docs/ and drop it at the root of the `pb` folder.

3. Start the PocketBase server

```bash
cd pb
./pocketbase serve
```

4. Change to `ui` dir

```bash
cd ../ui
```

5. Create `.env` file

```bash
cp .env.example .env
```

6. Start the Vite server

```bash
npm install && npm run dev
```

## Customization

App name, logo, and colors can be customized using the `customize.json` file.

## Deployment

One neat thing about PocketBase is that it can also serve our static frontend assets. to do that simply follow these steps:

1. Add the server URL where your PocketBase instance is hosted to `VITE_PROD_PB_URL` in the `.env` file

2. Build a production-ready bundle

```bash
cd ui
npm run build
```

3. Copy the contents of the `dist` folder over to `pb_public`

### Using Docker


### Docker Run

```bash
docker build -t ecourse .
docker run -p 8090:8090 -v /your/storage/path/:/app/pb/pb_data ecourse
```

### Docker Compose

```bash
docker compose up
```

## Feedback & Suggestions

Feel free to open an issue/PR if you find any bugs or want to request new features.

## License

Licensed under the MIT License, Copyright © 2024
