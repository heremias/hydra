<script>
    import { info, formPath } from '../stores.js';
    import Navbar from "../components/Navbar.svelte";
    import Card from "../components/Card.svelte";
    import Spinner from "../components/Spinner.svelte";
    import Error from "../components/Error.svelte";
    
    export let params = {};
    
    let path = params.wild;
    
    if (!path) {
        path = "";
    }

    async function getList(path) {
        const data = {
            "directory": path
        }
        let resp = await fetch(
            'http://0.0.0.0:8883/cgi-bin2/list.py', 
            {
                method: 'POST',
                body: JSON.stringify(data)
            }
        );
        let output = await resp.text();
        output = JSON.parse(output);
        filters = output.list;
        return output;
    }

    let filters;

    let data = getList(path);

    function handleSubmit(itemList) {
        formPath.set(path);
        setInfo(itemList);
    }

    function setInfo(itemList) {
        info.set(itemList);
    }

    // Filters

    let currentFilter="All";

    function updateFilter(list, filter) {
        currentFilter = filter;
        if (filter === 'All')
            filters = list;
        else
            filters = list.filter((data) => data.group === filter);
    }

</script>

<Navbar/>

{#await data}
    <Spinner/>

{:then data}

    {#if data.hasDirectories}
        {#each data.list as item, color (item)}
            <Card
                name={item.key}
                description={item.description} 
                href={"#/list1/" + path + "/" + item.directory} 
                color={color+1}
            />
        {/each}
    {:else}
        <div class="container">
            <div class="filter-container">
                {#each data.groups as group (group)}
                    <button class="btn-1" class:active={currentFilter === group} on:click={() => updateFilter(data.list, group)}>
                        {group}
                    </button>
                {/each}
            </div>
            
            <div class="data-container">
                {#each filters as item (item)}
                    <div on:click={() => handleSubmit(item, path)}>
                        <a href="#/form/" class="btn-2"> 
                            {item.key}
                            <svg width="28" height="30" class="arrow" viewBox="0 0 58 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9.66699 22.5H48.3337" stroke="#E5E5E6" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M31.417 9.375L48.3337 22.5L31.417 35.625" stroke="#E5E5E6" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </a>
                    </div>
                {/each}
            </div>
        </div>
    {/if}

{:catch error}
    <Error/>
{/await}

<style>

    .container {
        margin-left: 5%;
        margin-right: 5%;
        margin-top: 5%;
    }

    .btn-1 {
        font-family: 'Source Sans Pro';
        font-weight: bold;
        font-size: 20px;
        color: #A67F75;
        background-color: #00030E;
        border: none;
        outline: none;
        padding: 2% 2.5%;
        cursor: pointer;
    }

    .btn-2 {
        background-color: #23262F;
        border: none;
        color: #EAEBEC;
        padding: 20px 34px;
        text-align: center;
        font-family: 'PT Sans';
        font-size: 23px;
        margin: 10px; 
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        text-decoration: none;
        border-radius: 5px;
        outline: none;
        box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.25);
        max-width: 60%;
    }

    .arrow {
        padding-left: 3%;
    }
    
    .active {
        font-size: 26px;
        color: #FF9676;
        background-color: #0D101A;
        cursor: pointer;
    }

    .data-container {
        background-color: #0D101A;
        padding: 3% 0% 3% 3%;
        margin-right: 3%;
        display: grid;
        grid-gap: 0% 0%;
        grid-template-columns: 50% 50%;
    }
</style>
