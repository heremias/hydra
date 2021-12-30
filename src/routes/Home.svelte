<script>
    import { info, formPath } from '../stores.js';
    import Navbar from "../components/Navbar.svelte";
    import Hero from "../components/Hero.svelte";
    import Card from "../components/Card.svelte";
    import Spinner from "../components/Spinner.svelte";
    import Error from "../components/Error.svelte";
    
    let path = "";

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
        return output;
    }

    let data = getList(path);

    function handleSubmit(itemList, path) {
        formPath.set(path);
        setInfo(itemList);
    }

    function setInfo(itemList) {
        info.set(itemList);
    }
</script>

<div class="main">
    <Navbar/>
    <Hero/>
</div>

{#await data}
    <Spinner/>

{:then data}

    {#if data.hasDirectories}
            {#each data.list as item, color (item)}
                <Card
                    name={item.key}
                    description={item.description} 
                    href={"#/list1/" + path + "/" + item.directory} 
                    color={color}
                />
            {/each}
    {/if}

{:catch error}
    <Error/>
{/await}

<style>
    .main {
        height: 100vh;
    }
</style>
