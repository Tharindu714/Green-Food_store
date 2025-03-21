<?php

require "connection.php";
session_start();

$txt = $_POST["text"];
$select = $_POST["search"];

$query = "SELECT * FROM `product`";

if (!empty($txt) && $select == 0) {
    $query .= " WHERE `title` LIKE '%" . $txt . "%'";
} else if (empty($txt) && $select != 0) {
    $query .= " WHERE `category_id`='" . $select . "'";
} else if (!empty($txt) && $select != 0) {
    $query .= " WHERE `title` LIKE '%" . $txt . "%' AND `category_id`='" . $select . "'";
}
?>
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12" data-wow-delay="0.1s">
                <div class="section-title">
                    <h3 class="title" style="color: #02d592;">Searched Products</h3>
                </div>
            </div>
            <?php
            $selected_rs = Database::search($query);
            $selected_num = $selected_rs->num_rows;
            for ($x = 0; $x < $selected_num; $x++) {
                $selected_data = $selected_rs->fetch_assoc();
            ?>
                <div class="col-lg-3 col-md-4 col-sm-12 mb-4">
                    <div class="product">
                        <div class="product-img img-fluid">
                            <?php
                            $image_resultSet1 = Database::search("SELECT * FROM `image` WHERE `product_id` = '" . $selected_data["id"] . "';");
                            $image_data1 = $image_resultSet1->fetch_assoc();
                            ?>
                            <img src="<?php echo $image_data1["code"]; ?>" alt="" class="img-fluid w-100">
                            <?php

                            $start_date = new DateTime($selected_data["datetime_added"]);

                            $tdate = new DateTime();
                            $tz = new DateTimeZone("Asia/Colombo");
                            $tdate->setTimezone($tz);

                            $end_date = new DateTime($tdate->format("Y-m-d H:i:s"));

                            $difference = $end_date->diff($start_date);

                            if ($difference->format('%d') >= 7) {
                            ?>
                            <?php
                            } else {
                            ?>
                                <div class="product-label">
                                    <span class="new">NEW</span>
                                </div>
                            <?php
                            }
                            ?>
                        </div>
                        <div class="product-body">
                            <h3 class="product-name"><a href="#"><?php echo $selected_data["title"]; ?></a></h3>
                            <h4 class="product-price">Rs.<?php echo $selected_data["price"]; ?>.00</h4>
                            <?php
                            $Rf_rs1 = Database::search("SELECT * FROM `feedback`WHERE `product_id`='" . $selected_data["id"] . "' ORDER BY `date` DESC");
                            $Rf_num1 = $Rf_rs1->num_rows;
                            $Rf_data1 = $Rf_rs1->fetch_assoc();
                            ?>
                            <div class="product-rating">
                                <?php
                                if ($Rf_num1 == 0) {
                                ?>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <?php
                                } else {
                                    for ($i = 1; $i <= 5; $i++) {
                                        if ($i <= $Rf_data1["type"]) {
                                    ?>
                                            <i class="fa fa-star"></i>
                                        <?php
                                        } else {
                                        ?>
                                            <i class="fa fa-star-o"></i>
                                <?php
                                        }
                                    }
                                }
                                ?>
                            </div>
                            <div class="product-btns">
                                <?php
                                if (isset($_SESSION["user"])) {
                                    $email = $_SESSION["user"]["email"];
                                    $watchlist_Resultset3 = Database::search("SELECT * FROM `wishlist` WHERE `product_id`='" . $selected_data["id"] . "' AND `user_email`= '" . $email . "'");
                                    $watchlist_num3 = $watchlist_Resultset3->num_rows;

                                    if ($watchlist_num3 == 1) {
                                ?>
                                        <button class="add-to-wishlist" onclick='addWishlist(<?php echo $selected_data["id"]; ?>);'>
                                            <i class="fa fa-heart text-success" id='heart<?php echo $selected_data["id"]; ?>'></i>
                                            <span class="tooltipp">Remove</span>
                                        </button>
                                    <?php
                                    } else {
                                    ?>
                                        <button class="add-to-wishlist" onclick='addWishlist(<?php echo $selected_data["id"]; ?>);'>
                                            <i class="fa fa-heart text-dark" id='heart<?php echo $selected_data["id"]; ?>'></i>
                                            <span class="tooltipp">Add to wishlist</span>
                                        </button>
                                <?php
                                    }
                                }
                                ?>
                                <?php
                                if (isset($_SESSION["user"])) {
                                ?>

                                    <button class="quick-view">
                                        <a href="<?php echo "SingleProductView.php?id=" . ($selected_data["id"]); ?>">
                                            <i class="fa fa-hand-o-right"></i>
                                            <span class="tooltipp">See More...</span>
                                        </a>
                                    </button>
                                <?php
                                } else {
                                }
                                ?>
                            </div>
                        </div>
                        <?php
                        if (isset($_SESSION["user"])) {
                        ?>
                            <div class="add-to-cart">
                                <button class="add-to-cart-btn" onclick="AddtoCart(<?php echo $product_data['id']; ?>);"><i class="fa fa-shopping-cart"></i> add to cart</button>
                            </div>
                        <?php
                        } else {
                        }
                        ?>
                    </div>
                </div>

            <?php
            }
            ?>
        </div>
    </div>
</div>