import React from "react";
import {
  VStack,
  Text,
  Heading,
  Button,
  HStack,
  Center,
  Img,
  Wrap,
  WrapItem,
} from "@chakra-ui/react";
import LinkButton from "../LinkButton/LinkButton";
import ServiceCard from "./ServiceCard";
function Services() {
  return (
    <VStack
      bg={"black"}
      color={"white"}
      height={"fit-content"}
      minH={"100vh"}
      width={"100%"}
      paddingTop={"5vh"}
      paddingBottom={"5vh"}
      spacing={5}
      backgroundImage={"url(./services_bg_.jpg)"}
      backgroundSize={"cover"}
      justify={"center"}
      borderRadius={"10px"}
      borderBottomLeftRadius={"0"}
      borderBottomRightRadius={"0"}
    >
      <Center width={"100%"}>
        <Heading fontSize={"3.5em"}>Our Services</Heading>
      </Center>

      <Wrap justify={"center"} spacing={5}>
        <WrapItem>
          <ServiceCard
            title={"Collection Launch"}
            description={
              "For a digital creator like you , we provide you with speed , ease and low cost NFT Collection launch way without writing any code and spending zero dollars"
            }
            btnLink={"https://github.com/rentweb3/Rentweb3-docs"}
            btnCaption={"Know More"}
          />
        </WrapItem>
        <WrapItem>
          <ServiceCard
            title={"Dapps renting"}
            description={
              "For each whitelist or sale smart contract that you created on our platform, you can rent a dapp of your choice.These dapps are built by one of the best developers in the space"
            }
            btnCaption={"Rent Dapp"}
            btnLink={"/RentDappInformation"}
          />
        </WrapItem>
        <WrapItem>
          <ServiceCard
            title={"NFT Renting"}
            description={
              "Rent your favorite NFTs at low cost and use them in games or metaverse. If you are an NFT holder , you can earn passive income while still being the owner of that NFT."
            }
            btnCaption={"Rent NFTs"}
            btnLink={"/ExploreNfts"}
          />
        </WrapItem>
      </Wrap>
    </VStack>
  );
}

export default Services;
