<script>
  import customize from "../../customize.json";
  import resolveConfig from "tailwindcss/resolveConfig";
  import tailwindConfig from "../../tailwind.config";
  import { slide } from "svelte/transition";
  import { quintOut } from "svelte/easing";
  import Icon from "@iconify/svelte";
  import { scrollToCourse } from "../lib/scroll";
  import { isSidebarVisible, isSearchVisible, isLoading } from "../lib/store";
  import { pb, courses, resources, currentUser } from "../lib/pocketbase";
  import { navigate, useLocation } from "svelte-routing";
  import LanguageSelector from './LanguageSelector.svelte';
  import { t } from "../lib/i18n";

  export let isCoursesVisible = true;

  const { name, logo, logo_size } = customize;
  const { theme } = resolveConfig(tailwindConfig);
  const mainColor = theme.colors.main.slice(1);
  const location = useLocation();

  $: if ($location.pathname && window.innerWidth <= 1024) {
    isSidebarVisible.set(false);
  }

  function logout() {
    pb.authStore.clear();
    navigate("/login");
  }
</script>

{#if $isSidebarVisible}
  <aside
    transition:slide={{
      duration: 300,
      easing: quintOut,
      axis: "x",
    }}
    class="flex h-full w-80 flex-none flex-col gap-5 border-r-[1.5px] border-r-white/5 bg-white/5 p-5 lg:w-full lg:border-none"
  >
    <div class="flex items-center justify-between">
      <img
        aria-hidden="true"
        on:click={() => navigate("/")}
        style="width: {logo_size}px;"
        class="cursor-pointer transition hover:opacity-80"
        src={logo}
        alt={`${name} Logo`}
      />
      <button
        on:click={() => ($isSidebarVisible = !$isSidebarVisible)}
        class="group hidden items-center justify-center rounded-full bg-transparent p-2 transition hover:bg-white/10 lg:flex"
      >
        <Icon
          class="flex-shrink-0 text-lg text-white/50 transition group-hover:text-white"
          icon="ph:arrow-line-left"
        />
      </button>
    </div>
    

    {#if $isLoading}
      <div
        class="hidden w-full max-w-56 animate-pulse rounded-full bg-white/10 p-1 sm:block"
      ></div>
    {:else if $courses.length > 0}
      <h2
        class="hidden items-center gap-2 rounded-md bg-white/5 px-3 py-2 text-white/50 sm:flex"
      >
        <Icon class="flex-shrink-0" icon="ph:graduation-cap" />
        {$courses.length}
        {$courses.length === 1 ? $t("courseAssigned") : $t("coursesAssigned")}
      </h2>
    {/if}

    <button
      on:click={() => ($isSearchVisible = !$isSearchVisible)}
      class="flex w-full items-center gap-2 rounded-md border-[1.5px] border-white/10 bg-transparent p-2 text-white/50 outline-none transition hover:border-transparent hover:bg-white/10"
    >
      <Icon class="flex-shrink-0 text-base" icon="ph:magnifying-glass" />
      {$t("search")}
    </button>

    <div class="hide-scrollbar flex flex-grow flex-col gap-5 overflow-y-scroll">
      {#if $isLoading && isCoursesVisible && window.innerWidth >= 1024}
        <div class="w-full space-y-3">
          <div
            class="w-1/3 animate-pulse rounded-full bg-white/10 p-1 lg:w-1/2 lg:max-w-28"
          ></div>
          <div
            class="w-1/2 animate-pulse rounded-full bg-white/10 p-1 lg:w-full lg:max-w-44"
          ></div>
          <div
            class="w-1/3 animate-pulse rounded-full bg-white/10 p-1 lg:w-1/2 lg:max-w-28"
          ></div>
          <div
            class="w-1/2 animate-pulse rounded-full bg-white/10 p-1 lg:w-full lg:max-w-44"
          ></div>
        </div>
      {:else if isCoursesVisible && $courses.length > 0}
        <div class="flex flex-col gap-2 lg:hidden">
          <h3
            class="flex items-center gap-2 text-xs tracking-[2px] text-white/50"
          >
            <Icon class="flex-shrink-0 text-base" icon="ph:graduation-cap" />
            {$t("COURSES")}
          </h3>
          <div>
            {#each $courses as course (course.id)}
              <button
                aria-hidden="true"
                on:click={() => scrollToCourse(course.id)}
                class="line-clamp-1 w-full truncate rounded-md bg-transparent p-2 text-start text-white/50 transition hover:bg-white/10 hover:text-white"
              >
                {course.title}
              </button>
            {/each}
          </div>
        </div>
      {/if}

      {#if $isLoading}
        <div class="w-full space-y-3">
          <div
            class="w-1/3 animate-pulse rounded-full bg-white/10 p-1 lg:w-1/2 lg:max-w-28"
          ></div>
          <div
            class="w-1/2 animate-pulse rounded-full bg-white/10 p-1 lg:w-full lg:max-w-44"
          ></div>
          <div
            class="w-1/3 animate-pulse rounded-full bg-white/10 p-1 lg:w-1/2 lg:max-w-28"
          ></div>
          <div
            class="w-1/2 animate-pulse rounded-full bg-white/10 p-1 lg:w-full lg:max-w-44"
          ></div>
        </div>
      {:else if $resources.length > 0}
        <div class="flex flex-col gap-2">
          <h3
            class="flex items-center gap-2 text-xs tracking-[2px] text-white/50"
          >
            <Icon class="flex-shrink-0 text-base" icon="ph:link" />
            {$t("RESOURCES")}
          </h3>
          <div>
            {#each $resources as resource}
              <a
                class="line-clamp-1 w-full truncate rounded-md bg-transparent p-2 text-start text-white/50 transition hover:bg-white/10 hover:text-white"
                href={resource.link}
                target="_blank">{resource.name}</a
              >
            {/each}
          </div>
        </div>
      {/if}
    </div>
    {#if $isLoading}
      <div class="flex w-full items-center gap-3">
        <div class="animate-pulse rounded-full bg-white/10 p-4"></div>
        <div class="flex-1 space-y-3">
          <div
            class="w-1/2 animate-pulse rounded-full bg-white/10 p-1 lg:max-w-28"
          ></div>
          <div
            class="w-full animate-pulse rounded-full bg-white/10 p-1 lg:max-w-44"
          ></div>
        </div>
      </div>
    {:else}
      <div class="flex items-center justify-between gap-5">
        <div class="flex items-center gap-2">
          <img
            src={`https://api.dicebear.com/7.x/initials/svg?seed=${$currentUser.username}&backgroundColor=${mainColor}`}
            alt={`${$currentUser.username}'s profile avatar`}
            class="h-8 w-8 rounded-full"
          />
          <div>
            <h3 class="line-clamp-1 truncate text-wrap break-all">
              {$currentUser.username}
            </h3>
            <h4 class="line-clamp-1 truncate text-wrap break-all text-white/50">
              {$currentUser.email}
            </h4>
          </div>
        </div>
        <button
          on:click={logout}
          class="flex items-center justify-center rounded-md bg-transparent p-2 text-red-400 outline outline-[1.5px] outline-red-400/20 transition hover:bg-red-400/20"
        >
          <Icon class="flex-shrink-0 text-base" icon="ph:sign-out" />
        </button>
      </div>
    {/if}

    <LanguageSelector />
  </aside>
{/if}


