<script>
    export let name, description, href, color;
    let colors = ["#0F121C", "#00030E"];
</script>

<div class="container" style="background-color: {colors[color%2]};">
    <div class="tech-container">
        <div class="tech">
            <div class="tech-name">
                {name}
            </div>
            <div class="tech-description">
                {description}
            </div>
        </div>
        <div class="button-container">
            <a class="button" href={href}>
                <div class="button-text">
                    GO
                </div>
                <svg width="40" height="35" class="button-img" viewBox="0 0 58 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9.66748 22.4998H48.3341" stroke="#00030E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M31.4175 9.37488L48.3341 22.4999L31.4175 35.6249" stroke="#00030E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                    
            </a>
        </div>
    </div>
</div>

<style>

    .container {
        height: 100vh;
        width: 100%;
    }
    
    .tech-container {
        padding-left: 9%;
        padding-top: 7.5%;
        display: flex;
    }

    .tech {
        text-align: left;
        width: 50%;
        padding-top: 18px;
    }

    .tech-name {
        font-size: 3em;
        font-weight: 600;
        color: #FFC1AE;
    }

    .tech-description {
        width: 50%;
        padding-top: 20%;
        padding-bottom: 20%;
        font-size: 30px;
        font-family: PT Sans;
    }
    
    .button-container {
        width: 50%;
        /* align-content: center; */
        display: flex;
        /* justify-content:center; */
        flex-direction:row; /*default value is row*/
        /* text-align: center;
        align-self: center; */
    }

    .button {
        background: radial-gradient(196.46% 196.46% at 50.15% -24.78%, #FF8B68 0%, #FF4B14 100%);
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
        border-radius: 8px;
        height: 75px;
        color: #00030E;
        /* width: 20%; */
        /* margin: 10% 10%; */
        /* padding-right: 10%;
        padding-left: 10%; */
        /* width: 250px; */
        align-self: center;
    }

    .button:hover {
        cursor: pointer;
    }

    .button-text {
        font-family: Poppins;
        font-weight: bold;
        font-size: 45px;
        display: inline-block;
        padding-left: 50px;
        padding-right: 3px;
    }

    .button-img {
        padding-left: 3px;
        padding-right: 30px;
    }

</style>