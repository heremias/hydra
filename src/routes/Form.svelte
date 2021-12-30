<script>
    import { info, formPath } from '../stores.js';
    import Navbar from "../components/Navbar.svelte";
    import Spinner from "../components/Spinner.svelte";

    let key = $info.key;
    let input;
    let data = {};

    function loadInputs() {
        let input = $info.inputs;
        for (let i=0; i< input.length; i++) {    
            data[input[i].variable] = input[i].default;
        }
        return input;
    }

    input = loadInputs();

    let output;

    async function submitHandler() {
        window.scrollTo(0,0);
        output = "loading";
        let new_data = {...data};
        
        // Clear all inputs on submit
        loadInputs();

        new_data["option"] = key;
        
        let resp = await fetch(
            `http://0.0.0.0:8883/cgi-bin2/${$formPath}/menu.py`,
            {
                method: 'POST',
                body: JSON.stringify(new_data)
            }
        );
        output = await resp.text();
    }
</script>

<Navbar/>

<h3 id="option">{key}</h3>

<div class="container-flex">
    
    <div class="form">
        <form on:submit|preventDefault={submitHandler} > <!-- target='op_frame' -->

            {#await input}
                <p>Fetching Data...</p>
            {:then values}

                {#each values as value (value)}
                    {#if value.name}
                        <p>{value.name}</p>
                        {#if value.type===""}
                            <input class="input-text" type="text" spellcheck="false" bind:value="{data[value.variable]}">
                        <!-- {:else if} -->
                        {/if}
                    {/if}
                {/each}
                
            {:catch error}
                <p style="color: red">{error.message}</p>
            {/await}

            <br/>

            <button class="btn" type="submit">
                Submit
                <svg width="30" class="arrow" height="23" viewBox="0 0 40 31" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M7.33398 15.5964H32.8443" stroke="#00030E" stroke-width="3.2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M21.6836 6.93726L32.8444 15.5965L21.6836 24.2557" stroke="#00030E" stroke-width="3.9585" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>                    
            </button>

        </form>

    </div>


    <div class="output">
        {#if !output}
            <div class="no-output">
                No output
            </div>
        
        {:else if output === "loading"}
            <Spinner/>

        {:else}
            <pre>
                {output}
            </pre>
        {/if}
    </div>

</div>


<style>

    .container-flex {
        display: flex;
        flex-direction: row;
        justify-content: space-around;
        /* padding: 20px; */
    }

    #option {
        text-transform: capitalize;
        color: #FF9676;
        font-family: "Source Sans Pro";
        font-weight: bold;
        font-size: 40px;
        padding-left: 9%;
    }

    .form {
        color: #9CF1E2;
        display: flex; 
        text-transform: capitalize;
        flex-direction: column;
        align-items: center;
        font-family: 'PT Sans';
        font-size: 20px;
    }

    .output {
        overflow: auto; 
        /* height: 100%; */
        width: 600px;
        background-color: #0B1124;
        color: chartreuse;
        font-family: 'PT Mono', monospace;
        padding: 3%;
        border-radius: 5px;
        margin-bottom: 45px;
    }

    .input-text {
        background-color: #0D101A;
        box-shadow: 5px 7px #000208;
        border: none;
        border-radius: 5px;
        resize: vertical;
        padding-left: 20px;
        color: #E8E9EA;
        width: 250px;
        height: 50px;
        font-size: small;
        font-family: 'Poppins';
        transition: ease-in-out, width .35s ease-in-out;
    }

    /* .input-text:focus {
        outline: none;
        width: 270px;
    } */

    .no-output {
        text-align: center;
        color: #9dace2;
        font-size: 25px;
        font-family: 'Poppins';
    }

    .btn {
        background: radial-gradient(196.46% 196.46% at 50.15% -24.78%, #FF8B68 0%, #FF4B14 100%);
        width: 230px;
        height: 67px;

        box-shadow: 0px 3.25664px 3.25664px rgba(0, 0, 0, 0.25);
        border-radius: 6.51327px;

        font-family: 'Poppins';
        font-weight: bold;
        font-size: larger;
        
        margin-top: 45px;
        margin-bottom: 45px;

        display: flex;
        justify-content: center;
        align-items: center;

        cursor: pointer;
        text-decoration: none;

        border: none;
        outline: none;
    }

    .arrow {
        padding-left: 5px;
    }

    .btn:hover {
       background-color: #d83548;
    }
    
</style>
