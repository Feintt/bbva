defmodule BbvaChallengeWeb.FakePayHTML do
  use Phoenix.Component

  def show(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="es">
      <head>
        <meta charset="utf-8" />
        <title>Checkout – Pago simulado</title>
        
    <!-- Bootstrap 5 vía CDN para grid y estilos base -->
        <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
        />
        
    <!-- Font-Awesome para iconos de pasos -->
        <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
        />

        <style>
          /* ———— CSS que enviaste ———— */
          body{min-height:100vh;display:flex;align-items:center;justify-content:center;background-color:#000022;font-size:.8rem}
          .card{max-width:1000px;margin:2vh}
          .card-top{padding:.7rem 5rem}
          .card-top a{float:left;margin-top:.7rem}
          #logo{font-family:'Dancing Script';font-weight:bold;font-size:1.6rem}
          .card-body{padding:0 5rem 5rem 5rem;background-image:url("https://i.imgur.com/4bg1e6u.jpg");background-size:cover;background-repeat:no-repeat}
          @media(max-width:768px){.card-body{padding:0 1rem 1rem 1rem;background-image:url("https://i.imgur.com/4bg1e6u.jpg");background-size:cover;background-repeat:no-repeat}.card-top{padding:.7rem 1rem}}
          .row{margin:0}
          .upper{padding:1rem 0;justify-content:space-evenly}
          #three{border-radius:1rem;width:22px;height:22px;margin-right:3px;border:1px solid blue;text-align:center;display:inline-block}
          #payment{margin:0;color:blue}
          .icons{margin-left:auto}
          form span{color:rgb(179,179,179)}
          form{padding:2vh 0}
          input{border:1px solid rgba(0,0,0,.137);padding:1vh;margin-bottom:4vh;outline:none;width:100%;background-color:rgb(247,247,247)}
          input:focus::-webkit-input-placeholder{color:transparent}
          .header{font-size:1.5rem}
          .left{background-color:#fff;padding:2vh}
          .left img{width:2rem}
          .left .col-4{padding-left:0}
          .right .item{padding:.3rem 0}
          .right{background-color:#fff;padding:2vh}
          .col-8{padding:0 1vh}
          .lower{line-height:2}
          .btn{background-color:#1704bd;border-color:#1704bd;color:#fff;width:100%;font-size:.7rem;margin:4vh 0 1.5vh 0;padding:1.5vh;border-radius:0}
          .btn:hover{color:#fff}
          a{color:#000}
          a:hover{text-decoration:none;color:#000}
          input[type=checkbox]{width:unset;margin-bottom:unset}
          #cvv{background-image:linear-gradient(to left,rgba(255,255,255,.575),rgba(255,255,255,.541)),url("https://img.icons8.com/material-outlined/24/000000/help.png");background-repeat:no-repeat;background-position-x:95%;background-position-y:center}
        </style>
      </head>

      <body>
        <!-- ---------- Tarjeta principal ---------- -->
        <div class="card shadow-lg">
          <!-- Header -->
          <div class="card-top border-bottom text-center">
            <a href="#">Back to shop</a>
            <span id="logo">MiPyMe Pay</span>
          </div>

          <div class="card-body">
            <!-- Barra de pasos -->
            <div class="row upper text-white">
              <span><i class="fa fa-check-circle-o"></i> Shopping bag</span>
              <span><i class="fa fa-check-circle-o"></i> Order details</span>
              <span id="payment"><span id="three">3</span>Payment</span>
            </div>

            <div class="row">
              <!-- Columna izquierda: datos de tarjeta -->
              <div class="col-md-7">
                <div class="left border">
                  <div class="row align-items-center mb-3">
                    <span class="header col">Payment</span>
                    <div class="icons col-auto">
                      <img src="https://img.icons8.com/color/48/000000/visa.png" />
                      <img src="https://img.icons8.com/color/48/000000/mastercard-logo.png" />
                      <img src="https://img.icons8.com/color/48/000000/maestro.png" />
                    </div>
                  </div>
                  
    <!-- FORMULARIO -->
                  <form method="post">
                    <input
                      type="hidden"
                      name="_csrf_token"
                      value={Plug.CSRFProtection.get_csrf_token()}
                    />

                    <span>Cardholder's name:</span>
                    <input name="card[holder]" placeholder="Linda Williams" required />

                    <span>Card Number:</span>
                    <input
                      name="card[number]"
                      placeholder="0125 6780 4567 9909"
                      maxlength="19"
                      inputmode="numeric"
                      required
                    />

                    <div class="row">
                      <div class="col-4">
                        <span>Expiry date:</span>
                        <input name="card[expiry]" placeholder="YY/MM" maxlength="5" required />
                      </div>
                      <div class="col-4">
                        <span>CVV:</span>
                        <input name="card[cvv]" id="cvv" maxlength="4" required />
                      </div>
                    </div>

                    <input type="checkbox" id="save_card" />
                    <label for="save_card">Save card details to wallet</label>

                    <button class="btn mt-3">Pagar {@payment.amount} {@payment.currency}</button>
                  </form>
                </div>
              </div>
              
    <!-- Columna derecha: resumen -->
              <div class="col-md-5">
                <div class="right border">
                  <div class="header">Order Summary</div>
                  <p>1 item</p>

                  <div class="row item">
                    <div class="col-4 align-self-center">
                      <img class="img-fluid" src="https://i.imgur.com/79M6pU0.png" />
                    </div>
                    <div class="col-8">
                      <div class="row"><b>$ {@payment.amount}</b></div>
                      <div class="row text-muted">Pago QR MiPyMe</div>
                      <div class="row">Qty: 1</div>
                    </div>
                  </div>

                  <hr />

                  <div class="row lower">
                    <div class="col text-start">Subtotal</div>
                    <div class="col text-end">$ {@payment.amount}</div>
                  </div>
                  <div class="row lower">
                    <div class="col text-start">Delivery</div>
                    <div class="col text-end">Free</div>
                  </div>
                  <div class="row lower">
                    <div class="col text-start"><b>Total to pay</b></div>
                    <div class="col text-end"><b>$ {@payment.amount}</b></div>
                  </div>

                  <p class="text-muted text-center mt-3">Complimentary Shipping &amp; Returns</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        
    <!-- Opcional: Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
        </script>
      </body>
    </html>
    """
  end

  def success(assigns) do
    ~H"""
    <div class="min-h-screen flex flex-col justify-center items-center bg-success text-white">
      <h2 class="display-4 mb-3">¡Pago procesado ✔︎!</h2>
      <p>Puedes cerrar esta ventana.</p>
    </div>
    """
  end
end
