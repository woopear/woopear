<div class="loader hidden lg:block">
  <span style="--i:1;" />
  <span style="--i:2;" />
  <span style="--i:3;" />
  <span style="--i:4;" />
  <span style="--i:5;" />
  <span style="--i:6;" />
  <span style="--i:7;" />
  <span style="--i:8;" />
  <span style="--i:9;" />
  <span style="--i:10;" />
</div>

<style>
  .loader {
    position: absolute;
    top: 60%;
    left: 15%;
    width: 250px;
    height: 150px;
  }

  .loader span {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    transform: translateX(calc(50px * var(--i)));
    cursor: pointer;
  }
  .loader span::before {
    content: '';
    position: absolute;
    box-sizing: border-box;
    top: 0;
    left: 0;
    width: 25px;
    height: 25px;
    background-color: rgba(253, 238, 188, 0.363);
    border: 4px solid #0090e1;
    border-radius: 50%;
    box-shadow: 0 0 20px #0090e1, -100px -200px 0 #0090e1, -500px -200px 20px #0090e1,
      800px 200px 0 #0090e1, 600px 200px 20px #0090e1, 700px -200px 0 #0090e1,
      100px -200px 20px #0090e1, -300px 200px 0 #0090e1, -900px 200px 20px #0090e1;
    animation: animate 10s linear infinite;
    animation-delay: calc(-0.12s * var(--i));
    transform-origin: 35px;
    transition: 1.5s;
  }

  .loader:hover span::before {
    transform-origin: 25px;
    box-shadow: 0 0 20px #0090e1, -100px -200px 0 #0090e1, -500px -200px 20px #0090e1,
      800px 200px 0 #0090e1, 600px 200px 20px #0090e1, 700px -200px 0 #0090e1,
      100px -200px 20px #0090e1, -300px 200px 0 #0090e1, -900px 200px 20px #0090e1;
  }
  .loader:active span::before {
    transform-origin: 50px;
    box-shadow: 0 0 20px #00efff, -100px -200px 0 #00efff, -500px -200px 20px #00efff,
      800px 200px 0 #00efff, 600px 200px 20px #00efff, 700px -200px 0 #00efff,
      100px -200px 20px #00efff, -300px 200px 0 #00efff, -900px 200px 20px #00efff;
  }

  @keyframes animate {
    0% {
      transform: rotate(0deg);
      filter: hue-rotate(0deg);
    }
    100% {
      filter: hue-rotate(720deg);
      transform: rotate(360deg);
    }
  }
</style>
